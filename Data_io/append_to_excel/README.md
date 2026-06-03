# `append_to_excel.m`

Append data to an existing Excel worksheet without overwriting previous content.  
Automatically finds the first empty row and writes tables, cell arrays, or numeric matrices.

---

## Syntax

```matlab
append_to_excel(filename, data)
append_to_excel(filename, data, sheetname)
append_to_excel(..., Name, Value)
```

## Description

- `append_to_excel(filename, data)` appends `data` to the **first worksheet** of the existing Excel file `filename`.  
- `append_to_excel(filename, data, sheetname)` appends to the specified worksheet (name or index).  
- Accepts optional name‑value pairs for fine control.

**Key behaviour:**
- Writes column headers **only if the worksheet is completely empty** (avoids duplicate headers).
- Works with `table`, `cell array`, or numeric/logical matrix.
- Preserves existing formatting by default (no auto‑fit unless requested).
- On Windows, can auto‑fit column widths using Excel Automation (optional).

---

## Input Arguments

### `filename` (required)
String or character vector – path to an **existing** Excel file (`.xlsx`, `.xls`).  
*File must already exist; create it first with `writetable` or `writecell`.*

### `data` (required)
Data to append. Supported types:
- **`table`** – writes variable names as headers only when sheet is empty.
- **`cell`** – writes without headers.
- **`numeric` / `logical`** – automatically converted to cell array, written without headers.

### `sheetname` (optional, default = `1`)
- Numeric – sheet index (e.g., `1` for first sheet).  
- String/char – sheet name (e.g., `'Results'`).  
*If the sheet does not exist, an error is thrown.*

### Name‑Value Pair Arguments

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `WriteVariableNames` | logical | `true` | If `true` and `data` is a table, write headers **only when the sheet is empty**. Set to `false` to never write headers. |
| `AutoFitWidth` | logical | `false` | If `true` and running on **Windows with Excel**, automatically adjust column widths after writing. |
| `PreserveFormat` | logical | `true` | Currently a placeholder (reserved for future use). Has no effect when `AutoFitWidth` is `true`. |

---

## Examples

### 1. Append a table to an existing sheet

```matlab
% Create initial file
initial = table([1;2], {'A';'B'}, 'VariableNames', {'ID', 'Letter'});
writetable(initial, 'mydata.xlsx', 'Sheet', 'Log');

% New rows to append
newRows = table([3;4], {'C';'D'}, 'VariableNames', {'ID', 'Letter'});
append_to_excel('mydata.xlsx', newRows, 'Log');
```

### 2. Append a cell array (no headers)

```matlab
rawLog = {'2025-06-03', 'Start process'; '2025-06-04', 'Completed'};
append_to_excel('mydata.xlsx', rawLog, 'Log');
```

### 3. Append a numeric matrix

```matlab
sensorData = [25.3, 0.78; 26.1, 0.82];
append_to_excel('measurements.xlsx', sensorData, 'Sheet1');
```

### 4. Auto‑fit column widths (Windows only)

```matlab
append_to_excel('report.xlsx', T, 'Summary', 'AutoFitWidth', true);
```

---

## Notes & Limitations

- **File must exist** – use `writetable` or `writecell` to create the file first.
- **AutoFitWidth** works **only on Windows** with Microsoft Excel installed. On other platforms, the option is silently ignored (a warning is issued).
- **Performance**: For very large Excel files, determining the last row may take a few seconds because it reads the first column of the whole sheet.
- **PreserveFormat** is not yet implemented; currently a placeholder for future improvements.
- The function uses `xlsfinfo` and `readtable` to detect the last row, which works for most modern Excel files.

---

## See Also

- `writetable`, `writecell` – create new Excel files  
- `readtable` – import data from Excel  
- `xlsfinfo` – get sheet information  

---

## License

Part of **MATLAB Utility** – MIT License. Feel free to use and modify.