%% JADVALE_ZARB (Multiplication Table)
% This script creates a multiplication table (Jadval-e Zarb) with dimensions:
%   n rows × m columns
% Each element (i,j) = i * j  (i = row index, j = column index)
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace (fixed typo)
close all;           % Close any open figure windows

%% 1. Get User Input with Validation
% Number of rows (n) – must be a positive integer
n = input('n ra vared konid (tedad satr-ha): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,1) ~= 0
    error('n must be a positive integer (e.g., 5, 10).');
end

% Number of columns (m) – must be a positive integer
m = input('m ra vared konid (tedad soton-ha): ');
if ~isscalar(m) || ~isnumeric(m) || m <= 0 || mod(m,1) ~= 0
    error('m must be a positive integer (e.g., 5, 10).');
end

%% 2. Warn if the table is very large (optional safety)
if n * m > 10000
    reply = input(sprintf('Table size %dx%d has %d elements. Display? (y/n): ', n, m, n*m), 's');
    if ~strcmpi(reply, 'y')
        disp('Operation cancelled.');
        return;
    end
end

%% 3. Create the Multiplication Table
% Preallocate matrix C of size n x m for speed
C = zeros(n, m);

% Nested loops: row index i (1..n), column index j (1..m)
for i = 1:n          % i = row number (satr)
    for j = 1:m      % j = column number (soton)
        C(i, j) = i * j;
    end
end

% Alternative vectorized version (faster, but loops are clearer for learning):
% C = (1:n)' * (1:m);

%% 4. Display the Result
clc;   % Clear command window again for clean output

fprintf('\n=====================================\n');
fprintf('Jadvale zarb (Multiplication Table)\n');
fprintf('Size: %d rows × %d columns\n', n, m);
fprintf('=====================================\n\n');

% Display the matrix with row and column indices for clarity
disp('    ');  % spacing for row labels
fprintf('     ');  % align column numbers
for j = 1:m
    fprintf('  %3d  ', j);
end
fprintf('\n');

for i = 1:n
    fprintf(' %2d |', i);   % row number
    for j = 1:m
        fprintf('  %3d ', C(i, j));
    end
    fprintf('\n');
end

% Alternative simple display (uncomment if you prefer raw matrix)
% disp(['Jadvale ', num2str(n), ' dar ', num2str(m), ' shoma =']);
% disp(C);

fprintf('\nPayan (End).\n');