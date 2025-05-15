# Bulk File Renamer

A Bash script to bulk rename files in a directory with a standardized pattern that includes a prefix, a counter, a suffix, and the current date.

## Features

- Automatically renames all files in a specified directory
- Filename format: `<prefix>_file_<counter>_<suffix>_<date>.<extension>`
- Counter is always included and increments automatically
- Includes a script to download random files for testing

## File Structure

```
.
├── bulkFilRenamer.sh             # Main renaming script
├── downloadTestFilesScript.sh   # Script to generate test files
└── file-organizer-test/         # Directory with test files (created by the test file script)
```

## Setup Instructions

1. **Clone the repository**:

   ```bash
   git clone https://github.com/Zapwap123/BashScript-Bulk-File-Renamer
   cd Bulk-File-Renamer
   ```

2. **Make the scripts executable**:

   ```bash
   chmod +x bulkFileRenamer.sh
   chmod +x downloadTestFilesScript.sh
   ```

3. **Run the test file generator**:
   This script will create a `file-organizer-test` directory and populate it with test files.

   ```bash
   ./downloadTestFilesScript.sh
   ```

4. **Run the renamer script**:
   You can run the script interactively:

   ```bash
   ./bulkFileRenamer.sh
   ```

   It will prompt for:

   - Directory to rename files in (or press Enter to use the current one)
   - Prefix (e.g., `Zeth`)
   - Suffix (e.g., `Anmawen`)
   - Date format (e.g., `%Y-%m-%d`)

   The script renames all files in the format:

   ```
   <prefix>_file_<counter>_<suffix>_<date>.<extension>
   ```

## Example

If you enter:

- Prefix: `Zeth`
- Suffix: `Anmawen`
- Date format: `%Y-%m-%d`

Files will be renamed like:

```
Zeth_file_1_Anmawen_2025-05-15.txt
Zeth_file_2_Anmawen_2025-05-15.png
...
```

## License

MIT License
