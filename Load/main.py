from datetime import datetime
import os

def log_time():
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    script_dir = os.path.dirname(os.path.abspath(__file__))
    log_file = os.path.join(os.path.dirname(script_dir), "timelog.txt")
    
    try:
        with open(log_file, "a") as f:
            f.write(f"{timestamp}\n")
        print(f"Successfully wrote to {log_file}")  # Debug output
    except IOError as e:
        print(f"Error writing to log file {log_file}: {e}")

if __name__ == "__main__":
    log_time()