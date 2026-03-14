#!/bin/zsh

# Check for venv existence
deactivate
VENV_DIR="venv"
REQ_FILE="requirements.txt"

deactivate
echo "venv is ready and dependencies are installed!"
if [ ! -d "$VENV_DIR" ]; then
    echo "venv not found. Creating new environment..."
    python3 -m venv "$VENV_DIR"
fi

echo "Activating venv and updating dependencies..."
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install -r "$REQ_FILE" || {
    echo "Dependency conflict detected. Recreating venv..."
    deactivate
    rm -rf "$VENV_DIR"
    python3 -m venv "$VENV_DIR"
    source "$VENV_DIR/bin/activate"
    pip install --upgrade pip
    pip install -r "$REQ_FILE"
}
pip install pre-commit
pre-commit install
deactivate

echo "venv is ready, dependencies and pre-commit are installed!"
