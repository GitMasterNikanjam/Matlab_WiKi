## Description 
Reads a CSV file containing numbers, text, and missing values (e.g., NaN, empty cells). Returns a table and optionally separate numeric/text arrays.

## Why it's useful for learning / fast dev
Teaches readtable with 'PreserveVariableNames', 'TreatAsMissing', and handling heterogeneous data – a very common real‑world scenario.

## How to use
```matlab
% Create a small messy CSV for demonstration
demoData = {'Name','Age','Score','Comment';
            'Alice','25','92.5','good';
            'Bob','','78','';
            'Charlie','30','NaN','late';
            'Diana','28','88.2','very good'};
writecell(demoData, 'test_mixed.csv');

% Read it with the utility
T = read_csv_mixed('test_mixed.csv')

% Also get numeric and text arrays
[T, nums, texts] = read_csv_mixed('test_mixed.csv')
```