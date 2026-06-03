function write_cell_to_csv(filename, cellData, varargin)
% WRITE_CELL_TO_CSV Export a cell array to a CSV file.
%   WRITE_CELL_TO_CSV(FILENAME, CELLDATA) writes the cell array CELLDATA
%   to a comma‑separated value (CSV) file. Numbers are written as numbers,
%   strings as text, and empty cells become empty fields.
%
%   Optional name-value pairs:
%       'Delimiter'      - Delimiter character (default: ',').
%       'WriteHeaders'   - If true, the first row of CELLDATA is treated
%                          as column headers (default: false).
%       'QuoteStrings'   - If true, enclose text in double quotes (default: false).
%       'Append'         - If true, append to existing file (default: false).
%       'Encoding'       - File encoding (default: 'UTF-8').
%
%   Examples:
%       % Create a mixed cell array
%       data = {'Name', 'Age', 'Score';
%               'Alice', 25, 92.5;
%               'Bob', [], 78;
%               'Charlie', 30, NaN};
%       write_cell_to_csv('output.csv', data);
%
%       % Write with headers and quoted strings
%       write_cell_to_csv('report.csv', data, 'WriteHeaders', true, 'QuoteStrings', true);
%
%   See also WRITETABLE, WRITECELL, FOPEN, FPRINTF

p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'cellData', @iscell);
addParameter(p, 'Delimiter', ',', @ischar);
addParameter(p, 'WriteHeaders', false, @islogical);
addParameter(p, 'QuoteStrings', false, @islogical);
addParameter(p, 'Append', false, @islogical);
addParameter(p, 'Encoding', 'UTF-8', @ischar);
parse(p, filename, cellData, varargin{:});

filename = char(p.Results.filename);
cellData = p.Results.cellData;
delim = p.Results.Delimiter;
useHeaders = p.Results.WriteHeaders;
quote = p.Results.QuoteStrings;
appendMode = p.Results.Append;
encoding = p.Results.Encoding;

% If using headers and the first row is not to be treated as data
if useHeaders && size(cellData,1) > 0
    headers = cellData(1,:);
    dataRows = cellData(2:end, :);
else
    headers = {};
    dataRows = cellData;
end

% Open file
if appendMode
    fid = fopen(filename, 'a', 'n', encoding);
else
    fid = fopen(filename, 'w', 'n', encoding);
end

if fid == -1
    error('Cannot open file for writing: %s', filename);
end

% Helper to format a single cell as CSV field
formatCell = @(c) formatCsvField(c, quote, delim);

% Write headers if present
if ~isempty(headers)
    line = strjoin(cellfun(formatCell, headers, 'UniformOutput', false), delim);
    fprintf(fid, '%s\n', line);
end

% Write each data row
for i = 1:size(dataRows,1)
    rowFields = cellfun(formatCell, dataRows(i,:), 'UniformOutput', false);
    line = strjoin(rowFields, delim);
    fprintf(fid, '%s\n', line);
end

fclose(fid);
fprintf('Wrote %d rows to %s\n', size(dataRows,1), filename);

end

function out = formatCsvField(value, quote, delim)
% Helper: convert a cell element to a CSV‑safe string.
if isempty(value)
    out = '';
elseif isnumeric(value) && isscalar(value)
    if isnan(value)
        out = '';
    elseif isinf(value)
        out = sprintf('"%s"', mat2str(value));
    else
        out = num2str(value);
    end
elseif islogical(value)
    out = sprintf('%d', value);
elseif ischar(value) || isstring(value)
    str = char(value);
    % Escape any delimiter inside the string
    if contains(str, delim) || (quote && contains(str, '"'))
        str = strrep(str, '"', '""');   % double up quotes
        out = sprintf('"%s"', str);
    elseif quote
        out = sprintf('"%s"', str);
    else
        out = str;
    end
else
    % Fallback: convert to string
    str = char(string(value));
    out = sprintf('"%s"', strrep(str, '"', '""'));
end
end