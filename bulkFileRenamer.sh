#!/bin/bash

# Script to bulk rename files in a directory with options for prefix, suffix, counter, and date format.
# Usage: ./bulkFilRenamer.sh -d <directory> -p <prefix> -s <suffix> -r <rename-pattern> -t <date-format>

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

# Optional user prompts for prefix, suffix, and date format
if [ -z "$prefix" ]; then
    read -p "Enter the prefix to add to filenames (press Enter to skip): " prefix
fi

if [ -z "$suffix" ]; then
    read -p "Enter the suffix to add to filenames (press Enter to skip): " suffix
fi

if [ -z "$date_format" ]; then
    read -p "Enter the date format (e.g., '%Y-%m-%d') (press Enter to skip): " date_format
fi

# Always use a rename pattern with counter
if [ -z "$rename_pattern" ]; then
    rename_pattern="file_#"
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

# Change to target directory
cd "$directory" || exit
counter=1

# Rename files
for file in *; do
    if [ -f "$file" ]; then
        extension="${file##*.}"
        base_pattern=$(echo "$rename_pattern" | sed "s/#/$counter/g")
        new_name="${prefix}${prefix:+_}${base_pattern}${suffix:+_}${suffix}${current_date:+_}${current_date}.${extension}"

        mv -- "$file" "$new_name"
        echo "Renamed: $file -> $new_name"

        ((counter++))
    fi
done

echo "Bulk renaming complete!"
