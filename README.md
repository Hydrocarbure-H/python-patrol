# Python Patrol
Pat Patrouille, Paw Patrol... Python Patrol ensures that the codebase adheres to the best practices and standards, thus enhancing code reliability, readability, and maintainability.
This little script is mainly used with Django Projects. Maybe some other Python frameworks would need other `--exclude` parameters or a different usage to launch the testsuite.

<img width="842" alt="image" src="https://github.com/user-attachments/assets/c0ed7cac-6f97-4a3b-adff-cb145ff36f7a">

## Table of Contents

1. [Features](#features)
2. [Requirements](#requirements)
3. [Dependencies](#dependencies)
4. [Usage](#usage)

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

## Requirements

To run this script, ensure you have the following installed and properly configured in your environment:

1. **Poetry**: Poetry is used for dependency management and packaging in Python projects. Follow the [official Poetry installation guide](https://python-poetry.org/docs/#installation) to install Poetry.

2. **Python 3.x**: Ensure you have Python 3.x installed on your system. You can download it from the [official Python website](https://www.python.org/downloads/).

3. **Project Dependencies**: Make sure all the necessary project dependencies are installed. You can install them using Poetry by running `poetry install`

## Dependencies

The script relies on various Python packages for code quality checks and formatting. These packages are specified in the `pyproject.toml` file under `[tool.poetry.dependencies]` and `[tool.poetry.dev-dependencies]`. Here are the main dependencies:

- **isort**: Used for sorting and organizing imports.
- **black**: Used for automatic code formatting.
- **mypy**: Used for static type checking.
- **pydocstyle**: Used for checking compliance with Python docstring conventions.
- **flake8**: Used for checking the code against PEP 8 style conventions.
- **pylint**: Used for static analysis to detect errors and style violations.
- **radon**: Used for calculating cyclomatic complexity.
- **bandit**: Used for analyzing the code for security issues.
- **pytest**: Used for running the test suite.

Ensure these packages are included in your `pyproject.toml` file. Here is an example of how to specify them:

```toml
[tool.poetry.dependencies]
python = "^3.8"
isort = "^5.9.3"
black = "^21.9b0"
mypy = "^0.910"
pydocstyle = "^6.1.1"
flake8 = "^3.9.2"
pylint = "^2.10.2"
radon = "^5.1.0"
bandit = "^1.7.0"
pytest = "^6.2.5"

[tool.poetry.dev-dependencies]
```

## Usage
Clone the repository containing the script:
```bash
git clone https://github.com/Hydrocarbure-H/python-patrol.git
```
Or add as a Git Submodule
```bash
mkdir -p scripts scripts/patrol
git submodule add https://github.com/Hydrocarbure-H/python-patrol.git patrol
mv patrol scripts/
```
Make the script executable
```bash
chmod +x scripts/patrol/patrol.sh
```
> **(Optional): Create a wrapper script `run.sh`**
```bash
#!/bin/bash

# Run the patrol script
./scripts/patrol.sh

# Run other scripts
# ./pat-patrouille.sh
# ./les-ratz.sh
# ./croc-scooby.sh
```
Make your script executable with a `chmod +x run.sh`
Then finaly run
```bash
./run.sh
```
