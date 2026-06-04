#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==================================================="
echo "     Starting Frontend and Backend Services"
echo "==================================================="

# 1. Detect OS and Terminal Capabilities
OS_TYPE="$(uname -s)"
HAS_GUI=false

if [ "$OS_TYPE" = "Darwin" ]; then
    HAS_GUI=true
elif [ -n "$DISPLAY" ] || [ -n "$WAYLAND_DISPLAY" ]; then
    HAS_GUI=true
fi

# Function to start backend
start_backend() {
    cd "$ROOT_DIR/backend"
    
    # Check for virtual environment
    VENV_PATH=""
    if [ -f ".venv/bin/activate" ]; then
        VENV_PATH=".venv/bin/activate"
    elif [ -f "venv/bin/activate" ]; then
        VENV_PATH="venv/bin/activate"
    elif [ -f "env/bin/activate" ]; then
        VENV_PATH="env/bin/activate"
    fi

    if [ -n "$VENV_PATH" ]; then
        echo "[Backend] Activating virtual environment..."
        source "$VENV_PATH"
    else
        echo "[Backend] No virtual environment found. Using global python..."
    fi

    echo "[Backend] Starting server..."
    python src/main.py
}

# Function to start frontend
start_frontend() {
    cd "$ROOT_DIR/frontend"

    # Check for runner (bun vs npm)
    if command -v bun &> /dev/null; then
        RUNNER="bun"
    else
        RUNNER="npm"
    fi

    echo "[Frontend] Detected runner: $RUNNER"

    # Install dependencies if node_modules is missing
    if [ ! -d "node_modules" ]; then
        echo "[Frontend] node_modules not found. Installing dependencies using $RUNNER..."
        if [ "$RUNNER" = "bun" ]; then
            bun install
        else
            npm install
        fi
    fi

    echo "[Frontend] Starting dev server..."
    if [ "$RUNNER" = "bun" ]; then
        bun run dev
    else
        npm run dev
    fi
}

# Run in separate windows/processes based on platform
if [ "$OS_TYPE" = "Darwin" ]; then
    # macOS: Open new terminal windows using AppleScript
    echo "[macOS] Spawning separate Terminal windows..."
    
    # Escape path double-quotes for AppleScript
    ESCAPED_ROOT=$(echo "$ROOT_DIR" | sed 's/"/\\"/g')
    
    # Start Backend Window
    osascript -e "tell application \"Terminal\" to do script \"cd \\\"$ESCAPED_ROOT/backend\\\" && ( [ -f .venv/bin/activate ] && source .venv/bin/activate || true ) && python src/main.py\""
    
    # Start Frontend Window
    osascript -e "tell application \"Terminal\" to do script \"cd \\\"$ESCAPED_ROOT/frontend\\\" && ( command -v bun >/dev/null && bun run dev || npm run dev )\""

elif [ "$OS_TYPE" = "Linux" ] && [ "$HAS_GUI" = true ] && command -v gnome-terminal &> /dev/null; then
    # Linux with gnome-terminal
    echo "[Linux] Spawning separate gnome-terminal windows..."
    
    # Start Backend
    gnome-terminal --title="Backend Server (FastAPI)" -- bash -c "cd '$ROOT_DIR/backend' && ( [ -f .venv/bin/activate ] && source .venv/bin/activate || true ) && python src/main.py; exec bash"
    
    # Start Frontend
    gnome-terminal --title="Frontend Dev (Vite)" -- bash -c "cd '$ROOT_DIR/frontend' && ( command -v bun >/dev/null && bun run dev || npm run dev ); exec bash"

elif [ "$OS_TYPE" = "Linux" ] && [ "$HAS_GUI" = true ] && command -v xterm &> /dev/null; then
    # Linux with xterm fallback
    echo "[Linux] Spawning separate xterm windows..."
    
    xterm -T "Backend Server (FastAPI)" -e "bash -c \"cd '$ROOT_DIR/backend' && ( [ -f .venv/bin/activate ] && source .venv/bin/activate || true ) && python src/main.py; exec bash\"" &
    xterm -T "Frontend Dev (Vite)" -e "bash -c \"cd '$ROOT_DIR/frontend' && ( command -v bun >/dev/null && bun run dev || npm run dev ); exec bash\"" &

else
    # Fallback for headless environments or other OS: Run both in background under same shell but manage lifecycle
    echo "[Fallback] Running processes in the background of this terminal..."
    
    # Clean up background processes on Ctrl+C
    trap 'echo -e "\nStopping all services..."; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit' INT TERM EXIT

    # Start backend in background and log
    start_backend &
    BACKEND_PID=$!
    echo "[System] Backend started with PID: $BACKEND_PID"

    # Start frontend in background and log
    start_frontend &
    FRONTEND_PID=$!
    echo "[System] Frontend started with PID: $FRONTEND_PID"

    # Wait for both processes
    wait $BACKEND_PID $FRONTEND_PID
fi

echo "==================================================="
echo "Scripts initialized."
echo "==================================================="
