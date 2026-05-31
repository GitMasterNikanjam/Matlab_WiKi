%% Advanced Matrix Transposition Example
% Author: MATLAB User
% Description: This script demonstrates two ways to transpose a matrix:
%              1) Using explicit nested loops (educational)
%              2) Using MATLAB's built-in transpose operator (fast)
%              It also validates user input, measures performance for large
%              matrices, and works with integer types like uint8.

% Clean up workspace and command window
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace
close all;           % Close all figure windows (if any)

%% 1. User Input with Validation
% Prompt user to enter a matrix. Use input with eval to allow expressions.
% Example valid inputs: [1 2; 3 4]  or  magic(3)  or  rand(2,5)
user_input = input('Enter your matrix (e.g., [1 2; 3 4] or magic(3)): ');

% Validate that the input is a numeric matrix (not empty, 2D, numeric)
if isempty(user_input)
    error('Input matrix cannot be empty.');
end
if ~ismatrix(user_input)
    error('Input must be a 2D matrix (vector or array).');
end
if ~isnumeric(user_input)
    error('Input must contain numeric values (int, double, etc.).');
end

% Store original matrix and its dimensions
A = user_input;
[rows, cols] = size(A);   % rows = number of rows, cols = number of columns

% Display original matrix in a clear format
fprintf('\n--- Original Matrix (%d x %d) ---\n', rows, cols);
disp(A);

%% 2. Loop-Based Transposition (Educational)
% This method explicitly swaps rows and columns using nested loops.
% It helps understand the transposition operation but is slow for large data.

% Preallocate a matrix C of appropriate size (cols x rows) to avoid dynamic growth.
% Initialise with zeros of the same data type as A to preserve type (e.g., uint8).
C = zeros(cols, rows, 'like', A);   % 'like' preserves data type

% Nested loops: outer loop over rows of A, inner loop over columns of A
for i = 1:rows
    for j = 1:cols
        % Transpose: element at (i,j) of A becomes element at (j,i) of C
        C(j, i) = A(i, j);
    end
end
% (We do not need "clear i" because i will be overwritten or goes out of scope)

%% 3. Display the Loop-Based Transpose
fprintf('\n--- Transpose using Nested Loops (%d x %d) ---\n', cols, rows);
disp(C);

%% 4. Built-in Transpose Operator (Fast & Recommended)
% MATLAB provides two built-in transpose options:
%   - A.'   : non-conjugate transpose (for real numbers, same as A')
%   - A'    : complex conjugate transpose (for complex numbers)
% Since our matrix is real, both are equivalent here.

D = A.';   % Built-in transpose

fprintf('\n--- Transpose using Built-in Operator (''.'') ---\n');
disp(D);

% Verify that both methods give identical results
if isequal(C, D)
    fprintf('\n✅ Verification passed: Loop result matches built-in transpose.\n');
else
    fprintf('\n❌ Verification failed – something went wrong with the loops.\n');
end

%% 5. Performance Comparison (for Large Matrices)
% Show why the built-in operator is preferred for real applications.

fprintf('\n--- Performance Comparison (1000x1000 matrix) ---\n');
large_mat = rand(1000, 1000);   % Generate a large random matrix

% Time the loop method
tic;
large_C = zeros(size(large_mat,2), size(large_mat,1), 'like', large_mat);
for i = 1:size(large_mat,1)
    for j = 1:size(large_mat,2)
        large_C(j, i) = large_mat(i, j);
    end
end
time_loop = toc;

% Time the built-in operator
tic;
large_D = large_mat.';
time_builtin = toc;

fprintf('Loop method time    : %.4f seconds\n', time_loop);
fprintf('Built-in operator   : %.4f seconds\n', time_builtin);
fprintf('Speedup factor      : %.2f x\n', time_loop / time_builtin);

%% 6. Example with uint8 Array (Image-like Data)
% This demonstrates how the same code works seamlessly with uint8.
fprintf('\n--- Example with uint8 Data (e.g., small grayscale image block) ---\n');

% Create a 3x4 uint8 matrix (values 0-255)
uint8_mat = uint8([10 20 30 40; 50 60 70 80; 90 100 110 120]);
fprintf('Original uint8 matrix (3x4):\n');
disp(uint8_mat);

% Transpose using built-in operator – works for any numeric type
uint8_trans = uint8_mat.';
fprintf('Transposed uint8 matrix (4x3):\n');
disp(uint8_trans);

% Note: The loop method using 'zeros(..., "like")' would also preserve uint8.