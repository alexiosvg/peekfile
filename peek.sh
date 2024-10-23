#!/bin/bash
# Print the first three lines of the file specified as the first argument
head -n 3 "$1"
echo "..."
# Print the last three lines of the file specified as the first argument
tail -n 3 "$1"
