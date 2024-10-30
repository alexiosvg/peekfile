#!/bin/bash

# Assign arguments to variables
FILE="$1"

# Check if the second argument is provided, if not, default to 3
if [ -z "$2" ]; then
    LINES=3
else
    LINES="$2"
fi

# Get the total number of lines in the file
TOTAL_LINES=$(cat "$FILE" | wc -l)

# Check if the file has 2X lines or less
if (( TOTAL_LINES <= 2 * LINES )); then
    # Print the full content of the file
    cat "$FILE"
else
    # Print a warning message followed by the first and last 'LINES' lines
    echo "Warning: The file has more than $((2 * LINES)) lines."
    head -n "$LINES" "$FILE"
    echo "..."
    tail -n "$LINES" "$FILE"
fi

