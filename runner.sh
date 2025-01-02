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
        
        # Git operations
        cd "${SCRIPT_DIR}"
        log "Starting git operations..."
        
        # Get random word for commit message
        WORD_FILE="${SCRIPT_DIR}/words.txt"
        if [ -f "$WORD_FILE" ]; then
            RANDOM_WORD=$(shuf -n 1 "$WORD_FILE")
        else
            RANDOM_WORD="update"
            log "words.txt not found, using default word"
        fi
        
        if git add .; then
            log "Git add successful"
            if git commit -m "${RANDOM_WORD}"; then
                log "Git commit successful"
                # Generate random number 1-10
                RAND_NUM=$(( $RANDOM % 10 + 1 ))
                log "Random number generated: $RAND_NUM"
                
                if [ $RAND_NUM -le 4 ]; then
                    if git push; then
                        log "Git push successful (40% probability hit)"
                    else
                        log "Git push failed"
                        exit 1
                    fi
                else
                    log "Skipping push (60% probability hit)"
                fi
            else
                log "Git commit failed"
                exit 1
            fi
        else
            log "Git add failed"
            exit 1
        fi
    else
        log "Error executing Python script. Exit code: $?"
        log "Error output: $output"
        exit 1
    fi
fi