# `read_specific_columns.m`

Read only selected columns from a CSV or Excel file – reduces memory usage and speeds up import when you only need a subset of columns.

---

## Syntax

```matlab
data = read_specific_columns(filename, columns)
data = read_specific_columns(filename, columns, Name, Value)
```

## Description

`data = read_specific_columns(filename, columns)` reads the file and returns a table containing **only** the columns you specify.

The `columns` argument can be:
- **Column names** – cell array or string array (e.g., `{'Name','Score'}` or `["Name","Score"]`)
- **Column indices** – numeric vector (e.g., `[1,3,5]`)

Name‑value pairs control header handling, sheet selection (Excel), row ranges, and other `readtable` options.

---

## Input Arguments

### `filename` (required)
Character vector or string – path to the file (`.csv`, `.txt`, `.xlsx`, `.xls`).

### `columns` (required)
Specification of which columns to read:
- **Cell/string array** of column names – matches the header row (case‑sensitive).
- **Numeric vector** – one‑based column indices.

### Name‑Value Pairs

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `Sheet` | string/numeric | `1` | For Excel files: sheet name or index. |
| `Range` | string | `''` | Cell range (e.g. `'A1:C100'`). |
| `ReadVariableNames` | logical | `true` | If `true`, the first row is treated as column headers. |
| `VariableNamingRule` | `'preserve'` or `'modify'` | `'preserve'` | Keep original column names exactly (`'preserve'`) or make them valid MATLAB identifiers (`'modify'`). |

Any additional name‑value pairs are passed directly to `readtable` (e.g. `'TreatAsMissing'`, `'TextType'`).

---

## Output

- **`data`** – MATLAB table containing only the requested columns.

---

## Examples

### 1. Read columns by name (CSV with headers)

```matlab
T = read_specific_columns('employees.csv', {'Name', 'Salary', 'Department'});
```

### 2. Read columns by index

```matlab
% Read columns 1, 4, and 6
T = read_specific_columns('data.xlsx', [1,4,6], 'Sheet', 'Sheet2');
```

### 3. File without headers – use indices and disable header reading

```matlab
% Assume file has no header row
T = read_specific_columns('noheader.csv', [2,3,5], 'ReadVariableNames', false);
```

### 4. Read a specific row range

```matlab
% Only rows 2 through 100, columns 'Name' and 'Score'
T = read_specific_columns('large.csv', {'Name','Score'}, 'Range', 'A2:F100');
```

### 5. Handle missing data (pass options to `readtable`)

```matlab
T = read_specific_columns('survey.csv', {'Age','Income'}, 'TreatAsMissing', {'N/A','NULL'});
```

---

## Notes

- For CSV/text files, the function automatically detects whether to use `VariableNamesLine` (newer MATLAB) or `ReadVariableNames` (older). It is compatible back to at least R2016b.
- If you request a column name that does not exist, an error lists all available columns from the file.
- Column indices are **1‑based** (the first column is `1`).
- When using `'Range'`, the range must include the header row if `ReadVariableNames` is `true`; otherwise, adjust the range accordingly.
- The function works with **both `.xls` and `.xlsx`** Excel files, as well as common text delimited files (`.csv`, `.txt`, `.dat`).

---

## See Also

- `readtable`, `detectImportOptions` – core import functions
- `write_formatted_table` – export tables with custom formatting (another utility in this repo)

---

## License

Part of **MATLAB Utility** – MIT License.
```