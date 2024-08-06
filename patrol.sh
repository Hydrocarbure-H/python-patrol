#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Color and icon definitions
WHITE_BOLD="\033[1;37m"
GREEN="\033[0;32m"
GREEN_BOLD="\033[1;32m"
RED="\033[0;31m"
NC="\033[0m"

run_command() {
  local cmd=$1
  local name=$2
  local icon=$3

  echo -e "${WHITE_BOLD}${icon} Running ${name}...${NC}"
  if ! output=$(eval "$cmd" 2>&1); then
    echo "$output"
    exit 1
  fi
  echo -e "${GREEN_BOLD}${name}${GREEN} completed successfully 👍${NC}"
}

# Generate stubs
generate_stubs() {
    package_name=$1
    output_dir=$2

    for dir in $(find $package_name -type d); do
        if [[ "$dir" == *"/migrations"* ]]; then
            continue
        fi

        if [ -f "$dir/__init__.py" ]; then
            module=$(echo $dir | tr / .)
            poetry run stubgen -p $module -o $output_dir > /dev/null
            if [ $? -ne 0 ]; then
                echo -e "${RED}Error generating stubs for $module${NC}"
                exit 1
            fi
        else
            for file in $(find $dir -maxdepth 1 -name "*.py"); do
                module=$(echo $file | sed 's|/|.|g' | sed 's|.py$||')
                poetry run stubgen -m $module -o $output_dir > /dev/null
                if [ $? -ne 0 ]; then
                    echo -e "${RED}Error generating stubs for $module${NC}"
                    exit 1
                fi
            done
        fi
    done
}

# Sorts and organizes imports in Python files using Black's style profile
run_command "poetry run isort . --profile black" "isort" "🔍"

# Automatically formats Python code according to Black's style
run_command "poetry run black ." "black" "🖤"

# Performs static type checking using Mypy in strict mode
run_command "poetry run mypy --strict --explicit-package-bases . " "mypy" "📏"

# Generates the stubs for every modules
echo -e "${WHITE_BOLD}🦆️ Generating stubs...${NC}"
output_dir="./stubs"

# Find all directories that contain an __init__.py file, indicating they are Python packages
packages=$(find . -type f -name "__init__.py" -exec dirname {} \; | sort -u)

for package in $packages; do
    # Remove the leading "./" from the package path
    package=${package#./}
    generate_stubs $package $output_dir
done

echo -e "${GREEN}Generation completed successfully 👍.${NC}"

# Checks code against PEP 8 style conventions
run_command "poetry run pycodestyle .  --max-line-length=100 --ignore=E999,W503 --exclude=migrations,*/__init__.py" "pycodestyle" "📝"

# Checks that docstrings in the code conform to style conventions.
# The following parameters will be ignored:
# - D100: Missing docstring in public module
# - D101: Missing docstring in public class
# - D102: Missing docstring in public method
# - D103: Missing docstring in public function
# - D104: Missing docstring in public package
# - D200: One-line docstring should fit on one line with quotes
# - D210: No whitespaces allowed surrounding docstring text
# - D401: First line should be in imperative mood; try rephrasing
# - D212: Multi-line docstring summary should start at the first line
# - D400: First line should end with a period
# - D415: First line should end with a period, question mark, or exclamation point
# - D203: 1 blank line required before class docstring
# - D205: 1 blank line required between summary line and description
run_command "poetry run pydocstyle .  --match='(?!.*migrations)(?!__init__).*\.py' --ignore=D100,D101,D102,D103,D104,D200,D210,D401,D212,D400,D415,D203,D205" "pydocstyle" "📚"

# Analyzes the code for potential errors using pyflakes and ignores f-string placeholder errors
run_command "poetry run flake8 --select=F --ignore=F541 ." "flakes8" "🔍"

# Find all directories that contain an __init__.py file, indicating they are Python packages
pylint_packages=$(find . -type f -name "__init__.py" -exec dirname {} \; | sort -u | tr '\n' ' ')

# Performs static analysis of the code to detect errors, bad practices, and style violations.
# The following parameters will be ignored:
# - missing-class-docstring (C0115): Missing class docstring
# - invalid-name (C0103): Invalid name pattern for variables, functions, etc.
# - E1101: Class member access on a possibly non-existent member (e.g., dynamic attributes)
# - E1136: Value is unsubscriptable (using square brackets on non-container)
# - R0903: Too few public methods (class has less than 2 public methods)
# - W0718: Catching too general exception (Exception)
# - W1309: Using an f-string without any interpolated variables
# - R0801: Duplicate code found
run_command "poetry run pylint $pylint_packages --ignore=migrations --disable=missing-class-docstring,invalid-name,E1101,E1136,R0903,W0718,W1514,W1309,R0801" "pylint" "🚨"

# Calculates the cyclomatic complexity of functions and methods in the code
run_command "poetry run radon cc . --min C" "radon" "📊"

# Analyzes the code for security issues
run_command "poetry run bandit -r . --exclude tests.py" "Bandit" "🔐"

# Runs the test suite using pytest
run_command "poetry run python3 manage.py test" "tests" "🧪"

echo -e "${GREEN_BOLD}All checks completed successfully 🍆${NC}"
