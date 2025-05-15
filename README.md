# Bulk File Renamer Bash Script

A simple bash script to rename files in bulk by adding a prefix, a suffix, a counter, and a date stamp.

## Features

- Automatically adds a counter to each file (mandatory)
- Optional prefix and suffix support
- Appends the current date in a customizable format
- Works on any directory (defaults to current if not specified)

## Usage

```bash
./bulkFilRenamer.sh [options]
```

### Options

| Flag | Description |
|------|-------------|
| `-d <directory>` | Directory containing files to rename (optional; defaults to current directory) |
| `-p <prefix>` | Prefix to add to filenames (optional) |
| `-s <suffix>` | Suffix to add to filenames (optional) |
| `-t <date-format>` | Include date using `date` format string (e.g., `%Y-%m-%d`) (optional) |
| `-h` | Show help message |

### Example

```bash
./bulkFilRenamer.sh -d file-organizer-test -p Zeth -s Anmawen -t "%Y-%m-%d"
```

This will rename files in the `file-organizer-test` directory to something like:

```
Zeth_file_1_Anmawen_2025-05-15.txt
Zeth_file_2_Anmawen_2025-05-15.jpg
...
```

## Requirements

- Bash shell
- Permissions to read/write in the target directory

## Author

Generated on 2025-05-15
