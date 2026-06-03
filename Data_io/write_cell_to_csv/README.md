# `write_cell_to_csv.m`

Export a **cell array** (with mixed data types) to a CSV file.  
Handles numbers, text, empty cells, `NaN`, `Inf`, and automatically escapes quotes.

---

## Syntax

```matlab
write_cell_to_csv(filename, cellData)
write_cell_to_csv(filename, cellData, Name, Value)
```

## Description

`write_cell_to_csv(filename, cellData)` writes the cell array `cellData` to a comma‑separated values (CSV) file. Numbers are written as numbers, strings as text, and empty cells become empty fields.

`write_cell_to_csv(..., Name, Value)` allows you to customise the delimiter, quoting behaviour, header handling, and more.

The function uses low‑level file I/O (`fprintf`) and works in all MATLAB versions without additional toolboxes.

---

## Input Arguments

### `filename` (required)
Character vector or string – path to the output CSV file.

### `cellData` (required)
Cell array of any size. Each cell can contain:
- Numeric scalar (`double`, `single`, `int`, etc.)
- Logical (`true`/`false`)
- Character vector or string
- `[]` (empty) – becomes an empty field
- `NaN` or `Inf` – become empty or quoted `"Inf"`/`"-Inf"`

### Name‑Value Pairs

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `Delimiter` | character | `','` | Field delimiter (e.g., `';'`, `'\t'`). |
| `WriteHeaders` | logical | `false` | If `true`, the **first row** of `cellData` is treated as column headers and written separately. |
| `QuoteStrings` | logical | `false` | If `true`, enclose all string fields in double quotes. Always quotes fields containing the delimiter or quotes. |
| `Append` | logical | `false` | If `true`, append data to an existing file (otherwise overwrite). |
| `Encoding` | character | `'UTF-8'` | File encoding (e.g., `'UTF-8'`, `'ISO-8859-1'`). |

---

## Examples

### 1. Basic export of mixed data

```matlab
data = {'Name', 'Age', 'Score';
        'Alice', 25, 92.5;
        'Bob',   [], 78;
        'Charlie', 30, NaN};
write_cell_to_csv('students.csv', data);
```

Contents of `students.csv`:
```csv
Name,Age,Score
Alice,25,92.5
Bob,,78
Charlie,30,
```

### 2. Write with headers and quoted strings

```matlab
write_cell_to_csv('report.csv', data, 'WriteHeaders', true, 'QuoteStrings', true);
```

Output:
```csv
"Name","Age","Score"
"Alice","25","92.5"
"Bob","","78"
"Charlie","30",""
```

### 3. Append rows to an existing CSV

```matlab
newRows = {'Diana', 28, 88.2; 'Eve', 29, 91.0};
write_cell_to_csv('students.csv', newRows, 'Append', true);
```

### 4. Use semicolon delimiter and no quotes

```matlab
write_cell_to_csv('data.csv', data, 'Delimiter', ';');
```

---

## Notes

- **Empty cells** become empty fields (two consecutive delimiters).
- **`NaN` values** become empty fields (no number written).
- **`Inf` / `-Inf`** are written as `"Inf"` / `"-Inf"` (quoted) to avoid misinterpretation.
- **Quotes inside strings** are doubled (e.g., `"nice"` → `"""nice"""` inside a quoted field), which follows standard CSV escaping.
- The function **does not** handle multidimensional cell arrays (2D only, as typical for tabular data).

---

## See Also

- `writecell` – built‑in (R2019b+) for similar functionality
- `writetable` – export tables to CSV
- `readcell` – import CSV as cell array
- `fprintf` – low‑level formatted output

---

## License

Part of **MATLAB Utility** – MIT License.
```