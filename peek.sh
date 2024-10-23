#!/bin/bash

# Assign arguments to variables
FILE="$1"
LINES="$2"

# Print the first 'LINES' lines of the file specified as the first argument
head -n "$LINES" "$FILE"
echo "..."
# Print the last 'LINES' lines of the file specified as the first argument
tail -n "$LINES" "$FILE"

