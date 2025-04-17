#!/bin/bash

# ──────────────────────────────
# Terminal Colors
# ──────────────────────────────
WHITE_BOLD="\033[1;37m"
GREEN_BOLD="\033[1;32m"
RED_BOLD="\033[1;31m"
NC="\033[0m"

# ──────────────────────────────
# Show help
# ──────────────────────────────
show_help() {
  echo -e "${WHITE_BOLD}Usage: ./patrol.sh [options]${NC}"
  echo ""
  echo "Options:"
  echo "  -h, --help        Show this help message and exit"
  echo "  -f, --fix         Enable fix mode (black and isort will modify the code)"
  echo ""
  echo "By default, the script only checks code quality without modifying files."
}

# ──────────────────────────────
# Parse CLI arguments
# ──────────────────────────────
parse_args() {
  FIX_MODE=false

  for arg in "$@"; do
    case $arg in
      -h|--help)
        show_help
        exit 0
        ;;
      -f|--fix)
        FIX_MODE=true
        ;;
      *)
        echo -e "${RED_BOLD}Unknown option: $arg${NC}"
        show_help
        exit 1
        ;;
    esac
  done
}

# ──────────────────────────────
# Run a command and report result
# ──────────────────────────────
run_command() {
  local cmd=$1
  local name=$2
  local icon=$3

  echo -ne "${WHITE_BOLD}${icon} Running ${name}...${NC}"

  output=$(eval "$cmd" 2>&1)
  exit_code=$?

  if [ "$exit_code" -ne 0 ]; then
    echo -e " ❌ ${NC}"
    echo "$output"

    local error_count
    local summary
    error_count=$(echo "$output" | wc -l)
    summary="${name} failed."

    if [ "$name" = "pydocstyle" ]; then
      local num_errors=$((error_count / 2))
      summary="${name} failed with ${num_errors} errors."
    elif [ "$name" = "pycodestyle" ]; then
      summary="${name} failed with ${error_count} errors."
    elif [ "$name" = "pylint" ]; then
      local num_errors=$((error_count - 4))
      summary="${name} failed with ${num_errors} errors."
    fi

    echo -e "${RED_BOLD}${summary}${NC}"
    exit 1
  fi
  echo -e " ✅${NC}"
}


# ──────────────────────────────
# Main script logic
# ──────────────────────────────
main() {
  parse_args "$@"

  # Define black/isort command based on FIX mode
  if [ "$FIX_MODE" = true ]; then
    ISORT_CMD="poetry run isort --settings ./pyproject.toml ."
    BLACK_CMD="poetry run black ."
  else
    ISORT_CMD="poetry run isort --check-only --settings ./pyproject.toml ."
    BLACK_CMD="poetry run black --check ."
  fi

  pylint_packages=$(find . -type f -name "__init__.py" -exec dirname {} \; | sort -u | tr '\n' ' ')

  # Checks to run (command|name|emoji)
  checks=(
    "$ISORT_CMD|isort|🔍"
    "$BLACK_CMD|black|🖤"
    "poetry run mypy --config-file=./.mypy.ini .|mypy|📏"
    "poetry run pycodestyle --config=./.pycodestyle .|pycodestyle|📝"
    "poetry run pydocstyle --config ./pyproject.toml .|pydocstyle|📚"
    "poetry run flake8 --config=./.flake8 .|flake8|🔍"
    "poetry run pylint --enable-all-extensions --rcfile ./.pylintrc $pylint_packages|pylint|🚨"
    "poetry run radon cc . --min C|radon|📊"
    "poetry run bandit -c pyproject.toml -r .|bandit|🔐"
  )

  # Execute checks
  for check in "${checks[@]}"; do
    IFS="|" read -r cmd name icon <<< "$check"
    run_command "$cmd" "$name" "$icon"
  done

  echo -e "\n${GREEN_BOLD}🎉 All checks passed successfully!${NC}"
}

# ──────────────────────────────
# Entry point
# ──────────────────────────────
main "$@"
