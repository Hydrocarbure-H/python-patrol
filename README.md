# Python Patrol
 Pat Patrouille, Paw Patrol... Python Patrol ensures that the codebase adheres to the best practices and standards, thus enhancing code reliability, readability, and maintainability.

## Features

- Sorting and organizing imports using `isort`
- Automatic code formatting with `black`
- Static type checking through `mypy`
- PEP 8 style checks with `pycodestyle`
- Docstring style checks using `pydocstyle`
- Error detection through `flake8`
- Code analysis with `pylint`
- Cyclomatic complexity measurement using `radon`
- Security analysis with `bandit`
- Running test suites

## Usage
Clone the repository containing the script:
```bash
git clone https://github.com/Hydrocarbure-H/python-patrol.git
```
Or Add as a Git Submodule
```bash
mkdir -p scripts scripts/patrol
git submodule add https://github.com/Hydrocarbure-H/python-patrol.git scripts/patrol
```
Make the script executable
```bash
chmod +x /path/to/your/project/scripts/patrol/python-patrol.sh
```
Create a wrapper script `run.sh`
```bash
#!/bin/bash

# Navigate to the scripts directory
cd scripts/patrol

# Pull the latest changes
git pull origin main

# Make sure the script is executable
chmod +x python-patrol.sh

# Run the patrol script
./python-patrol.sh

# Run other scripts
# ./pat-patrouille.sh

# Go back to your project directory
cd -
```
Make your script executable with a `chmod +x run.sh`
Then finaly run
```bash
./run.sh
```
## Tasks

1. **Sorts and organizes imports using `isort`**:
   `poetry run isort . --profile black`
   - This command sorts and organizes imports in Python files using Black's style profile.

2. **Formats the Python code using `black`**:
   `poetry run black .`
   - This command automatically formats Python code according to Black's style.

3. **Performs static type checking using `mypy`**:
   `poetry run mypy --strict --explicit-package-bases .`
   - This command performs static type checking using Mypy in strict mode.

4. **Generates type stubs for each module**:
   `poetry run stubgen -p $module -o $output_dir > /dev/null`
   - This command generates type stubs for every module, skipping migrations directories.

5. **Checks code against PEP 8 style conventions using `pycodestyle`**:
   `poetry run pycodestyle . --max-line-length=100 --ignore=E999,W503 --exclude=migrations,*/__init__.py`
   - This command checks the code against PEP 8 style conventions.

6. **Checks that docstrings conform to style conventions using `pydocstyle`**:
   `poetry run pydocstyle . --match='(?!.*migrations)(?!__init__).*\.py' --ignore=D100,D101,D102,D103,D104,D200,D210,D401,D212,D400,D415,D203,D205`
   - This command checks that docstrings in the code conform to style conventions.

7. **Analyzes the code for potential errors using `flake8`**:
   `poetry run flake8 --select=F --ignore=F541 .`
   - This command analyzes the code for potential errors using Pyflakes and ignores f-string placeholder errors.

8. **Performs static analysis using `pylint`**:
   `poetry run pylint $(find . -type f -name "__init__.py" -exec dirname {} \; | sort -u | tr '\n' ' ') --ignore=migrations --disable=missing-class-docstring,invalid-name,E1101,E1136,R0903,W0718,W1514,W1309,R0801`
   - This command performs static analysis of the code to detect errors, bad practices, and style violations.

9. **Calculates cyclomatic complexity using `radon`**:
   `poetry run radon cc . --min C`
   - This command calculates the cyclomatic complexity of functions and methods in the code.

10. **Analyzes the code for security issues using `bandit`**:
    `poetry run bandit -r . --exclude tests.py`
    - This command analyzes the code for security issues.

11. **Runs the test suite using `pytest`**:
    `poetry run python3 manage.py test > /dev/null`
    - This command runs the test suite using pytest.

## Usage

To use this script, follow these steps:

1. Clone the repository:

