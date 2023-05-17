#!/bin/bash

# Check if directory argument is provided
if [ $# -ne 1 ]; then
  echo "Remember to add a directory as an argument. Usage: $0 /path/to/images/"
  exit 1
fi

# Set the input and output directories
input_dir="$1"
output_dir="${input_dir}_optimized"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop through all JPEG and PNG files in the input directory
for file in "$input_dir"/*.{jpg,jpeg,png}; do
  # Check if the file exists and is a regular file
  if [ -f "$file" ]; then
    # Generate the output filename by replacing the input directory with the output directory
    output_file="$output_dir/${file##*/}"

    # Apply the convert command to resize and compress the image
    convert "$file" -resize "800x600>" -strip -quality 80 "$output_file"

    # Apply the img-optimize command to further optimize the image
    img-optimize "$output_file" >/dev/null
  fi
done

