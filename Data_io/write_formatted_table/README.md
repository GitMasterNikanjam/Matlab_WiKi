# `write_formatted_table.m`

Export a MATLAB table to a **formatted text file** – with custom delimiters, fixed‑width columns, numeric formatting, and optional quoting.

Ideal for generating reports, input files for legacy software, or any situation where you need precise control over the output layout.

---

## Syntax

```matlab
write_formatted_table(filename, T)
write_formatted_table(filename, T, Name, Value)
```

## Description

`write_formatted_table(filename, T)` writes the table `T` to a text file using a default **tab‑separated** format. Column widths are automatic.

`write_formatted_table(..., Name, Value)` allows you to:
- Change the delimiter (comma, semicolon, pipe, etc.)
- Apply a fixed numeric format (e.g., `'%.2f'`) to all numeric columns
- Use **fixed column widths** (no delimiter, aligned output)
- Include row names as a first column
- Quote string fields
- Suppress or customise headers

The function uses `fprintf` and requires no additional toolboxes.

---

## Input Arguments

### `filename` (required)
Character vector or string – path to the output text file.

### `T` (required)
MATLAB table – the data to export.

### Name‑Value Pairs

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `Delimiter` | character | `'\t'` | Field delimiter (e.g. `','`, `';'`, `'\|'`). Ignored if `FixedWidth` is used. |
| `Format` | character | `''` | `fprintf`‑style format for **all numeric columns** (e.g. `'%10.4f'`, `'%6d'`). Text columns always use `'%s'`. |
| `FixedWidth` | numeric vector | `[]` | Column widths in characters (e.g. `[10,15,8]`). Overrides `Delimiter` and creates a fixed‑width layout. |
| `WriteVariableNames` | logical | `true` | Include column headers as the first row. |
| `WriteRowNames` | logical | `false` | Include table row names as the first column (requires `T.Properties.RowNames` to exist). |
| `Encoding` | character | `'UTF-8'` | File encoding (e.g. `'ISO-8859-1'`). |
| `QuoteStrings` | logical | `false` | Enclose all string fields in double quotes. Quotes inside strings are escaped (`"` becomes `""`). |

---

## Examples

### 1. Basic tab‑separated file (default)

```matlab
T = table([1;2;3], {'Alice';'Bob';'Charlie'}, [92.5;78.3;88.7], ...
    'VariableNames', {'ID','Name','Score'});
write_formatted_table('output.txt', T);
```

Output (`output.txt`):
```
ID	Name	Score
1	Alice	92.5
2	Bob	78.3
3	Charlie	88.7
```

### 2. Comma‑separated CSV with numeric formatting

```matlab
write_formatted_table('data.csv', T, 'Delimiter', ',', 'Format', '%.2f');
```

Output (`data.csv`):
```
ID,Name,Score
1,Alice,92.50
2,Bob,78.30
3,Charlie,88.70
```

### 3. Fixed‑width columns (no delimiter)

```matlab
write_formatted_table('fixed.txt', T, 'FixedWidth', [5, 12, 8]);
```

Output (`fixed.txt`):
```
   ID Name         Score   
    1 Alice         92.5
    2 Bob           78.3
    3 Charlie       88.7
```

### 4. Include row names and quote strings

```matlab
T.Properties.RowNames = {'Row1','Row2','Row3'};
write_formatted_table('quoted.txt', T, 'WriteRowNames', true, 'QuoteStrings', true, 'Delimiter', '|');
```

Output (`quoted.txt`):
```
"RowName"|"ID"|"Name"|"Score"
"Row1"|1|"Alice"|92.5
"Row2"|2|"Bob"|78.3
"Row3"|3|"Charlie"|88.7
```

### 5. No headers, semicolon delimiter

```matlab
write_formatted_table('noheaders.csv', T, 'Delimiter', ';', 'WriteVariableNames', false);
```

Output (`noheaders.csv`):
```
1;Alice;92.5
2;Bob;78.3
3;Charlie;88.7
```

---

## Notes

- **Empty cells** become empty fields (delimiters appear consecutively).
- **Fixed‑width mode**: text fields are left‑aligned, numeric fields are right‑aligned. If a string is longer than the width, it is truncated.
- The `Format` option only affects **numeric** columns; text columns always use `'%s'`. To format individual columns differently, create a custom version by modifying the internal loop.
- Row names are only written if `WriteRowNames` is `true` **and** `T.Properties.RowNames` is non‑empty.

---

## See Also

- `writetable` – built‑in table export (more limited formatting)
- `fprintf` – low‑level formatted output
- `writecell` – export cell array to text file

---

## License

Part of **MATLAB Utility** – MIT License.
```