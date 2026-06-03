# `read_text_file_lines.m`

Process large text files **line by line** – ideal for logs, configuration files, or any text data too big to fit in memory.  
You provide a function that processes each line; the function collects and returns the results.

---

## Syntax

```matlab
out = read_text_file_lines(filename, processFunc)
out = read_text_file_lines(filename, processFunc, Name, Value)
```

## Description

`out = read_text_file_lines(filename, processFunc)` opens the text file `filename`, reads it line by line, applies the function handle `processFunc` to each line, and collects the output (if any) in a cell array `out`.

`processFunc` must accept **one string argument** (the current line) and can return any MATLAB data type (e.g., a processed value, a logical flag, or `[]` to discard the line).

The function is **memory‑efficient** – only one line is held in memory at a time.

Optional name‑value pairs control encoding, filtering, and output format.

---

## Input Arguments

### `filename` (required)
Character vector or string – path to the text file.

### `processFunc` (required)
Function handle that receives a line (as a character vector or string) and returns a result.  
- Return `[]` (empty array) to **exclude** this line from the output.
- Any other return value is stored in the output cell array (or table).

### Name‑Value Pairs

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `Encoding` | character vector | `'UTF-8'` | File encoding (e.g., `'UTF-8'`, `'ISO-8859-1'`). |
| `SkipEmpty` | logical | `true` | If `true`, lines that are empty or contain only whitespace are **not** passed to `processFunc` and do not count toward `MaxLines`. |
| `MaxLines` | positive integer | `Inf` | Maximum number of non‑skipped lines to process. |
| `HeaderLines` | non‑negative integer | `0` | Number of lines to **skip** at the beginning of the file (they are ignored completely). |
| `OutputFormat` | `'cell'` or `'table'` | `'cell'` | Return a column cell array (`'cell'`) or a table with one column named `'ProcessedData'` (`'table'`). |

---

## Output

- **`out`** – by default a **cell array** of the same height as the number of processed lines that returned a non‑empty value.  
If `OutputFormat` is `'table'`, a table with one variable `'ProcessedData'` is returned.

---

## Examples

### 1. Count lines containing a word (without storing results)

```matlab
% Count ERROR lines – we only need the side effect, so return nothing.
errorCount = 0;
read_text_file_lines('app.log', @(line) ...
    (contains(line, 'ERROR') && (errorCount = errorCount + 1)));
fprintf('Found %d errors.\n', errorCount);
```

*Note: Assignment inside an anonymous function is not allowed; use a separate function or the pattern below.*

**Better way to count: return a marker and sum afterwards**

```matlab
markers = read_text_file_lines('app.log', @(line) ...
    double(contains(line, 'ERROR')));
errorCount = sum([markers{:}]);
```

### 2. Extract timestamps from a log file

```matlab
timestamps = read_text_file_lines('server.log', @(line) ...
    extractBetween(line, '[', ']'));
```

### 3. Read first 100 lines (as strings)

```matlab
first100 = read_text_file_lines('data.txt', @(x) x, 'MaxLines', 100);
```

### 4. Skip a header and empty lines, then parse CSV‑like data

```matlab
% Assume file has 2 header lines, then comma‑separated values.
data = read_text_file_lines('measurements.csv', @(line) ...
    strsplit(line, ','), 'HeaderLines', 2, 'SkipEmpty', true);
```

### 5. Convert lines to numbers (ignore non‑matching lines)

```matlab
numbers = read_text_file_lines('mixed.txt', @(line) ...
    str2double(line));
% str2double returns NaN for non‑numeric lines – filter them out
numbers = numbers(~cellfun(@isnan, numbers));
```

---

## Notes

- The function **does not close the file until finished** – it is safe against errors (uses `fclose` in all cases).
- If `processFunc` throws an error, a warning is issued and processing continues with the next line.
- For **extremely large files** (e.g., >10 GB), consider using `memmapfile` or `textscan` with chunking; this line‑by‑line approach is still efficient but may be slower.
- The function uses `fgetl`, which removes newline characters. To keep trailing newlines, modify the internal code to use `fgets` and remove the newline manually.

---

## See Also

- `fopen`, `fgetl`, `fclose` – low‑level file I/O
- `textscan` – read formatted data in chunks
- `readtable` – for structured CSV/Excel files
- `fileread` – reads entire file (not memory‑efficient)

---

## License

Part of **MATLAB Utility** – MIT License.
```