#!/bin/bash
# Check if the first argument is provided 
if [[ -n $1 ]]; then
  folder="$1"
else
  folder="."
fi

# Check if the second argument is provided 
if [[ -n $2 ]]; then
  N="$2"
else
  N=0  # Default value for N if not provided
fi

# Check if the folder exists and is a directory
if [[ ! -d $folder ]]; then
  echo "Folder not found: $folder"
fi
# Find all fasta/fa files in the specified folder and its subfolders
files=$(find "$folder" -type f -name "*.fa" -o -name "*.fasta")
# Count the number of fasta/fa files
file_count=$( echo "$files" | grep -c .) #Count non-empty lines
echo "Number of FASTA files found: $file_count"

#Process each file to collect unique FASTA IDs
for file in $files; do
  awk '/^>/ {print $1}' "$file" >> temp_fasta_ids
done
#Count total unique FASTA IDs
unique_fasta_id_count=$(sort "temp_fasta_ids" | uniq | wc -l)
#Print the total number of unique  FASTA IDs
echo "Total number of unique FASTA IDs: $unique_fasta_id_count"
# Clean up the temporary file
rm "temp_fasta_ids"


#Process each file for detailed information
for file in $files; do
echo "Processing file: $file"
#Is it a symlink?
if [[ -h $file ]]; then
  echo "1) File is a symlink"
else
  echo "1) File is not a symlink"
fi

#How many sequences are inside?
sequence_count=$(grep -c '^>' "$file")
#What is the total sequence length? 
total_length=$(grep -v '^>' "$file" | sed 's/[-]//g' | sed 's/ //g' | tr -d '\n' | wc -c)

echo "2) Number of sequences: $sequence_count"
 echo "3) Total sequence length: $total_length"
#Does the file contain nucleotides or aminoacids? Symbol M which 
#Stands for Methionine is present in proteins and not nucleic acids
if [[ $(grep -v '^>' "$file" | grep -c 'M') -gt 0 ]]; then
  echo "4) File contains Amino Acids"
else
  echo "4) File contains Nucleotides"
fi
 
#Check if second argument is provided
if [[ -n $2 ]]; then
 N="$2"
else
 N=0
fi
#Display file content based on N
if [[ "$N" -gt 0 ]]; then
  total_lines=$(cat "$file" | wc -l)
 if [[ $total_lines -le $((2*"$N")) ]]; then
   echo "Displaying file's full content"
   cat "$file"
else
   echo "Displaying file's first and last "$N" lines"
   head -n $N "$file"
   echo "..."
   tail -n $N "$file"
  fi
else
  echo "To inspect file contents please provide a numerical second argument"
fi
done
