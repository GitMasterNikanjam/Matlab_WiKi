# `read_binary_matrix.m`

Read a binary file that contains a numeric matrix and reconstruct it in MATLAB.

Binary files are compact and fast to read, but you must know the **data type** and **matrix dimensions** in advance. This function handles both **column‑major** (MATLAB/ Fortran) and **row‑major** (C/C++/Python) storage orders.

---

## Syntax

```matlab
M = read_binary_matrix(filename, dataType, dims)
M = read_binary_matrix(filename, dataType, dims, 'ColumnMajor', tf)
```

## Description

`M = read_binary_matrix(filename, dataType, dims)` reads a binary file that stores a matrix with dimensions `dims` (e.g., `[rows, cols]`). The data type is specified by `dataType` (e.g., `'double'`, `'int16'`). The file is assumed to store data in **column‑major** order (the native order in MATLAB).

`M = read_binary_matrix(..., 'ColumnMajor', false)` tells the function that the binary file uses **row‑major** order. The function will automatically transpose the data after reading.

---

## Input Arguments

### `filename` (required)
Character vector or string – name of the binary file to read.

### `dataType` (required)
Data type of the stored numbers. Any type accepted by `fread` is allowed:

| Category          | Supported strings                                |
|-------------------|--------------------------------------------------|
| Unsigned integers | `'uint8'`, `'uint16'`, `'uint32'`, `'uint64'`   |
| Signed integers   | `'int8'`, `'int16'`, `'int32'`, `'int64'`       |
| Floating point    | `'single'` (float32), `'double'` (float64)      |

### `dims` (required)
Two‑element (or more) vector specifying the dimensions of the matrix, e.g., `[3,4]` for a 3‑by‑4 matrix. The total number of elements must exactly match the file size.

### Name‑Value Pair

| Name | Value | Default | Description |
|------|-------|---------|-------------|
| `ColumnMajor` | logical | `true` | If `true`, the file stores data column by column (MATLAB style). If `false`, the file stores data row by row (C/Python style). |

## Output

- **`M`** – matrix of size `dims` with the numeric type `dataType`.

---

## Examples

### 1. Write and read a double matrix (column‑major)

```matlab
% Create and save a 4x4 magic square as binary
A = magic(4);
fid = fopen('magic.bin', 'wb');
fwrite(fid, A, 'double');
fclose(fid);

% Read it back
M = read_binary_matrix('magic.bin', 'double', [4,4]);
isequal(A, M)   % true
```

### 2. Read a row‑major matrix (e.g., saved by a C program)

Suppose a C program wrote a 2x3 matrix in row‑major order:

```c
// C code that writes row by row
float data[2][3] = {{1.1, 2.2, 3.3}, {4.4, 5.5, 6.6}};
FILE *f = fopen("row_major.bin", "wb");
fwrite(data, sizeof(float), 6, f);
fclose(f);
```

Read it in MATLAB:

```matlab
M = read_binary_matrix('row_major.bin', 'single', [2,3], 'ColumnMajor', false);
disp(M)
%     1.1000    2.2000    3.3000
%     4.4000    5.5000    6.6000
```

### 3. Reading a 3D array

The function also works for 3D or higher dimensions. The `dims` vector can have any length:

```matlab
% Write a 4x5x6 array
original = rand(4,5,6);
fid = fopen('3d.bin', 'wb');
fwrite(fid, original, 'double');
fclose(fid);

% Read it back
reconstructed = read_binary_matrix('3d.bin', 'double', [4,5,6]);
isequal(original, reconstructed)   % true
```

---

## How It Works

1. Opens the binary file with `fopen(..., 'rb')`.
2. Reads all bytes as a vector using `fread(..., inf, dataType)`.
3. Checks that the number of read elements matches `prod(dims)`.
4. If `ColumnMajor` is `true`, reshapes the vector directly (MATLAB stores column‑wise).
5. If `ColumnMajor` is `false`, reshapes as row‑major and then transposes.

---

## When to Use This

- **Exchanging data with other languages** – C, C++, Python (NumPy), Fortran.
- **Working with raw sensor logs** – many devices write binary data.
- **Performance** – reading binary is faster than text (CSV) and uses less disk space.
- **Learning low‑level I/O** – a great introduction to `fread`, `fwrite`, and byte ordering.

---

## See Also

- `fread`, `fwrite` – low‑level binary I/O
- `readmatrix`, `readtable` – text and spreadsheet import
- `memmapfile` – for extremely large files that don't fit in memory

---

## License

Part of **MATLAB Utility** – MIT License.
```