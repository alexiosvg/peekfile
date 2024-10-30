#!/bin/bash

# Loop through each argument (file)
for FILE in "$@"; do
  # Count total lines in the file using cat and pipe to wc -l
  TOTAL_LINES=$(cat "$FILE" | wc -l)

  # Print the file name
  echo "File: $FILE"

  # Differentiate cases based on the number of lines
  if (( TOTAL_LINES == 0 )); then
    echo "Number of lines: 0 (empty file)"
  elif (( TOTAL_LINES == 1 )); then
    echo "Number of lines: 1 (single line)"
  else
    echo "Number of lines: $TOTAL_LINES (more than one line)"
  fi
done

