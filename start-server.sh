#!/usr/bin/env bash

# Default to port 8000 if no argument is provided
PORT="${1:-8000}"

# Function to clean up background processes on exit
cleanup() {
    echo -e "\nStopping Python server (PID: $server_pid)..."
    kill "$server_pid" 2>/dev/null
    exit 0
}

# Trap Ctrl+C (SIGINT) and termination signals (SIGTERM)
trap cleanup SIGINT SIGTERM

echo "Starting Python server on port $PORT..."
python3 -m http.server "$PORT" >/dev/null 2>&1 &
server_pid=$!

# Give the server a brief moment to start before opening the browser
sleep 0.5

echo "Opening browser..."
xdg-open "http://localhost:$PORT/" >/dev/null 2>&1 &

echo "Server running (PID: $server_pid). Press Ctrl+C to stop."

# Keep the script running and waiting on the server process
wait "$server_pid"
