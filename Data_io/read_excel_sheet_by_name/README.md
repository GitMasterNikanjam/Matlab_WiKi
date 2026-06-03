# `read_excel_sheet_by_name.m`

Read a specific worksheet from an Excel file **by its name**, not by index.  
This makes your code more readable and robust – sheet order can change without breaking your scripts.

---

## Syntax

```matlab
data = read_excel_sheet_by_name(filename, sheetName)
data = read_excel_sheet_by_name(filename, sheetName, Name, Value)
```

## Description

`data = read_excel_sheet_by_name(filename, sheetName)` reads the worksheet named `sheetName` from the Excel file `filename` and returns a **table**.

`data = read_excel_sheet_by_name(..., 'Range', range)` reads only the specified cell range (e.g., `'A1:C10'`).

`data = read_excel_sheet_by_name(..., 'PreserveVariableNames', tf)` controls whether column headers are kept exactly as they appear (default `true`).

Any additional name‑value pairs are passed directly to `readtable` (e.g., `'TreatAsMissing'`, `'TextType'`).

---

## Input Arguments

### `filename` (required)
Character vector or string – path to the Excel file (`.xlsx`, `.xls`).

### `sheetName` (required)
Character vector or string – exact name of the worksheet to read.

### Name‑Value Pairs

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `Range` | character/string | `''` (entire sheet) | Cell range like `'A1:C10'` or `'B2:F100'`. |
| `PreserveVariableNames` | logical | `true` | Keep original column headers (allow spaces, special characters). If `false`, MATLAB makes them valid identifiers. |
| *Any other `readtable` option* | varies | – | Passed directly to `readtable` (e.g., `'TreatAsMissing'`, `'TextType'`). |

---

## Output

- **`data`** – MATLAB table containing the worksheet data.

---

## Examples

### 1. Read a sheet by name (full sheet)

```matlab
T = read_excel_sheet_by_name('financials.xlsx', 'Q1_Revenue');
disp(T)
```

### 2. Read only a specific cell range

```matlab
T = read_excel_sheet_by_name('report.xlsx', 'Summary', 'Range', 'B2:D20');
```

### 3. Treat certain strings as missing values

```matlab
T = read_excel_sheet_by_name('survey.xlsx', 'Responses', 'TreatAsMissing', {'N/A', 'NULL'});
```

### 4. Handle sheets with spaces in names

```matlab
% Sheet name: "Sales 2024"
T = read_excel_sheet_by_name('data.xlsx', 'Sales 2024');
```

---

## Error Handling

- If the file does not exist or cannot be read → error with clear message.
- If the specified `sheetName` is not found → error lists all available sheets.
- If reading fails (e.g., corrupt file) → error with original MATLAB exception.

---

## Compatibility

- Works on **all platforms** (Windows, macOS, Linux).
- Uses `sheetnames` (MATLAB R2019b+) if available; falls back to `xlsfinfo` for older versions.
- Requires no additional toolboxes.

---

## See Also

- `readtable` – read Excel into table (supports sheet index, but not name)
- `sheetnames` – list all sheet names in an Excel file
- `xlsfinfo` – legacy sheet info
- `append_to_excel` – write data without overwriting (another utility in this repo)

---

## License

Part of **MATLAB Utility** – MIT License.
```