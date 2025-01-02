from datetime import datetime
import os

# File path
script_dir = os.path.dirname(os.path.abspath(__file__))
file_path = os.path.join(script_dir, "..", "TIMELOG.md")

# Get the current timestamp
current_timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Read the file content
with open(file_path, "r") as file:
    lines = file.readlines()

# Append the timestamp to the first line
lines.insert(0, f"Timestamp: {current_timestamp}\n")

# If the file has more than 100 lines, truncate the excess lines
if len(lines) > 100:
    lines = lines[:100]

# Write the updated content back to the file
with open(file_path, "w") as file:
    file.writelines(lines)

print(f"Updated {file_path} with timestamp and ensured it's under 100 lines.")
