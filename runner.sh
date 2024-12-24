#!/bin/bash

# Set up logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "${SCRIPT_DIR}/cron.log"
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
MAIN_PY="${SCRIPT_DIR}/Load/main.py"

log "Starting runner script"

if [ -f "$MAIN_PY" ]; then
    log "Executing main.py..."
    if output=$(python3 "$MAIN_PY" 2>&1); then
        log "Python script executed successfully"
        log "Output: $output"
    else
        log "Error executing Python script. Exit code: $?"
        log "Error output: $output"
        exit 1
    fi
else
    log "Error: main.py not found at $MAIN_PY"
    exit 1
fi

log "Runner script completed"