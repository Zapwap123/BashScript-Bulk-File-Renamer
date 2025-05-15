#!/bin/bash

# Script to bulk rename files in a directory with options for prefix, suffix, counter, and date format.
# Usage: ./bulkFileRenamer.sh -d <directory> -p <prefix> -s <suffix> -r <rename-pattern> -t <date-format>


# Function to show usage information
function msgPromptHelper() {
    echo "Usage: $0 -d <directory> [-p <prefix>] [-s <suffix>] [-r <rename-pattern>] [-t <date-format>]"
    echo "Options:"
    echo "  -d <directory>       Directory to rename files in (optional; defaults to current)"
    echo "  -p <prefix>          Prefix to add to filenames (optional)"
    echo "  -s <suffix>          Suffix to add to filenames (optional)"
    echo "  -r <rename-pattern>  Rename pattern (e.g., 'file_#') where '#' is replaced by counter (optional)"
    echo "  -t <date-format>     Add current date to filenames (e.g., '%Y-%m-%d') (optional)"
    echo "  -h                   Display this help message"
}

# Parse command-line arguments
# Example: ./bulkFileRenamer.sh -d /path/to/directory -p prefix_ -s _suffix -r file_# -t '%Y-%m-%d'
while getopts "d:p:s:r:t:h" opt; do
    case "$opt" in
        d) directory="$OPTARG" ;;
        p) prefix="$OPTARG" ;;
        s) suffix="$OPTARG" ;;
        r) rename_pattern="$OPTARG" ;;
        t) date_format="$OPTARG" ;;
        h) msgPromptHelper; exit 0 ;;
        *) msgPromptHelper; exit 1 ;;
    esac
done

# Prompt for directory if not provided; use current directory if skipped
if [ -z "$directory" ]; then
    read -p "Enter the directory to rename files in (press Enter to use current directory): " directory
    if [ -z "$directory" ]; then
        directory="$PWD"
        echo "Using current directory: $directory"
    fi
fi

# Optional user prompts for prefix, suffix, rename pattern, and date format
if [ -z "$prefix" ]; then
    read -p "Enter the prefix to add to filenames (press Enter to skip): " prefix
fi

if [ -z "$suffix" ]; then
    read -p "Enter the suffix to add to filenames (press Enter to skip): " suffix
fi

if [ -z "$rename_pattern" ]; then
    read -p "Enter the rename pattern (e.g., 'file_#') (press Enter to skip): " rename_pattern
fi

if [ -z "$date_format" ]; then
    read -p "Enter the date format (e.g., '%Y-%m-%d') (press Enter to skip): " date_format
fi

# Verify that directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' does not exist."
    exit 1
fi

# Generate date string if format is given
if [ -n "$date_format" ]; then
    current_date=$(date +"$date_format")
else
    current_date=""
fi

# Process and rename files
cd "$directory" || exit
counter=1

for file in *; do
    if [ -f "$file" ]; then
        new_base=""
        
        # Apply rename pattern if provided
        if [ -n "$rename_pattern" ]; then
            new_base=$(echo "$rename_pattern" | sed "s/#/$counter/g")
        else
            new_base="$file"
        fi

        # Extract file name and extension
        base_name=$(basename "$file" | sed 's/\(.*\)\..*/\1/')
        extension="${file##*.}"

        # Create new name with prefix, new base name, current date, and suffix
        new_name="${prefix}${base_name}_${new_base}_${current_date}${suffix}.${extension}"

        # Rename the file
        mv -- "$file" "$new_name"
        echo "Renamed: $file -> $new_name"

        ((counter++))
    fi
done

echo "Bulk renaming complete!"
