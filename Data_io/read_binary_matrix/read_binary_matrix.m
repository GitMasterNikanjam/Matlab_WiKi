function M = read_binary_matrix(filename, dataType, dims, varargin)
% READ_BINARY_MATRIX Read a binary file containing a numeric matrix.
%   M = READ_BINARY_MATRIX(FILENAME, DATATYPE, DIMS) reads a binary file
%   that stores a matrix with dimensions DIMS (e.g., [rows, cols]).
%
%   M = READ_BINARY_MATRIX(FILENAME, DATATYPE, DIMS, 'ColumnMajor', false)
%   specifies the storage order. Default is true (MATLAB stores column‑wise).
%   Set to false if the file uses row‑major order (C/C++/Python).
%
%   Supported DATATYPE strings: 'uint8','int8','uint16','int16','uint32',
%   'int32','single','double' (or any type accepted by FREAD).
%
%   Example:
%       % Create a sample binary file
%       A = magic(4);                      % 4x4 matrix
%       fid = fopen('magic.bin', 'wb');
%       fwrite(fid, A, 'double');          % write column‑major
%       fclose(fid);
%
%       % Read it back
%       M = read_binary_matrix('magic.bin', 'double', [4,4])
%
%   See also FREAD, FWRITE

% Parse inputs
p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'dataType', @(x) ischar(x) || isstring(x));
addRequired(p, 'dims', @(x) isnumeric(x) && numel(x) >= 2);
addParameter(p, 'ColumnMajor', true, @islogical);
parse(p, filename, dataType, dims, varargin{:});

filename = char(p.Results.filename);
dataType = char(p.Results.dataType);
dims = p.Results.dims;
colMajor = p.Results.ColumnMajor;

% Open file for reading
fid = fopen(filename, 'rb');
if fid == -1
    error('Cannot open file: %s', filename);
end

% Read all data as a vector
data = fread(fid, inf, dataType);
fclose(fid);

% Check size
expectedNumel = prod(dims);
if numel(data) ~= expectedNumel
    error('Expected %d elements (%s), but file contains %d elements.', ...
          expectedNumel, mat2str(dims), numel(data));
end

% Reshape according to storage order
if colMajor
    % Data is stored column‑major (native MATLAB order)
    M = reshape(data, dims);
else
    % Row‑major order: read row‑wise, then transpose to column‑major
    M = reshape(data, fliplr(dims))';
end

end