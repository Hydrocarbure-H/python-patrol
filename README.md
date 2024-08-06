# Python Patrol
Pat Patrouille, Paw Patrol... Python Patrol ensures that the codebase adheres to the best practices and standards, thus enhancing code reliability, readability, and maintainability.
This little script is mainly used with Django Projects. Maybe some other Python frameworks would need other `--exclude` parameters or a different usage to launch the testsuite.
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

<img width="842" alt="image" src="https://github.com/user-attachments/assets/c0ed7cac-6f97-4a3b-adff-cb145ff36f7a">

## Usage
Clone the repository containing the script:
```bash
git clone https://github.com/Hydrocarbure-H/python-patrol.git
```
Or Add as a Git Submodule
```bash
mkdir -p scripts scripts/patrol
git submodule add https://github.com/Hydrocarbure-H/python-patrol.git patrol
mv patrol scripts/
```
Make the script executable
```bash
chmod +x scripts/patrol/patrol.sh
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
