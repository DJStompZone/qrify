#!/usr/bin/env bash

# Define the path to the Python script
QRIFY_SCRIPT="/usr/local/bin/qrify.py"

# Function to display usage
usage() {
    echo "Usage: qrify [--file <file>] [--raw \"<data>\"] [--output <output_base>] | [--stdin]"
    exit 1
}

# Parse arguments
if [ "$#" -eq 0 ]; then
    usage
fi

# Initialize variables
file_input=""
raw_input=""
stdin_input=""
output=""

# Process arguments
while [ "$#" -gt 0 ]; do
    case "$1" in
        --file)
            file_input="$2"
            shift 2
            ;;
        --raw)
            raw_input="$2"
            shift 2
            ;;
        --stdin)
            stdin_input="true"
            shift 1
            ;;
        -o|--output)
            output="$2"
            shift 2
            ;;
        *)
            usage
            ;;
    esac
done

# Check if an output base name was provided
if [ -z "$output" ]; then
    usage
fi

# Construct the command to run the Python script
cmd=("python3" "$QRIFY_SCRIPT" "-o" "$output")

# Add the appropriate input method
if [ -n "$file_input" ]; then
    cmd+=("--file" "$file_input")
elif [ -n "$raw_input" ]; then
    cmd+=("--raw" "$raw_input")
elif [ -n "$stdin_input" ]; then
    cmd+=("--stdin")
else
    usage
fi

# Execute the command
"${cmd[@]}"
