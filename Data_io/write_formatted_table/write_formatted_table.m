function write_formatted_table(filename, T, varargin)
% WRITE_FORMATTED_TABLE Export a table to a formatted text file.
%   WRITE_FORMATTED_TABLE(FILENAME, T) writes the table T to a text file
%   using a default format (tab‑separated, automatic width for each column).
%
%   WRITE_FORMATTED_TABLE(FILENAME, T, 'Delimiter', '\t') uses a custom delimiter.
%   WRITE_FORMATTED_TABLE(..., 'Format', '%12.4f') applies a fixed format to all
%   numeric columns (text columns use %s).
%   WRITE_FORMATTED_TABLE(..., 'FixedWidth', [10,15,8]) specifies column widths.
%   WRITE_FORMATTED_TABLE(..., 'WriteRowNames', true) writes row names as first column.
%
%   Optional name-value pairs:
%       'Delimiter'      - Field delimiter (default: '\t' for tab).
%       'Format'         - Format specifier for numeric columns (e.g., '%10.4f').
%                          Text columns always use '%s'.
%       'FixedWidth'     - Vector of column widths (overrides Delimiter).
%       'WriteVariableNames' - Include variable names as first row (default: true).
%       'WriteRowNames'  - Include row names as first column (default: false).
%       'Encoding'       - File encoding (default: 'UTF-8').
%       'QuoteStrings'   - Enclose text in quotes (default: false).
%
%   Examples:
%       % Basic tab‑separated file
%       T = table([1;2], {'A';'B'}, [1.234;5.678], 'VariableNames', {'ID','Name','Value'});
%       write_formatted_table('output.txt', T);
%
%       % Comma‑separated with custom numeric format
%       write_formatted_table('data.csv', T, 'Delimiter', ',', 'Format', '%.2f');
%
%       % Fixed width columns (no delimiter)
%       write_formatted_table('fixed.txt', T, 'FixedWidth', [5, 10, 8]);
%
%   See also WRITETABLE, FPRINTF, TABLE

p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'T', @istable);
addParameter(p, 'Delimiter', '\t', @ischar);
addParameter(p, 'Format', '', @ischar);
addParameter(p, 'FixedWidth', [], @(x) isnumeric(x) && isvector(x));
addParameter(p, 'WriteVariableNames', true, @islogical);
addParameter(p, 'WriteRowNames', false, @islogical);
addParameter(p, 'Encoding', 'UTF-8', @ischar);
addParameter(p, 'QuoteStrings', false, @islogical);
parse(p, filename, T, varargin{:});

filename = char(p.Results.filename);
delim = p.Results.Delimiter;
userFormat = p.Results.Format;
fixedWidth = p.Results.FixedWidth;
writeVarNames = p.Results.WriteVariableNames;
writeRowNames = p.Results.WriteRowNames;
encoding = p.Results.Encoding;
quote = p.Results.QuoteStrings;

% Get table data
varNames = T.Properties.VariableNames;
rowNames = T.Properties.RowNames;
data = table2cell(T);
nRows = height(T);
nCols = width(T);

% If using row names, prepend them to data and variable names
if writeRowNames
    if isempty(rowNames)
        error('Table has no row names. Set WriteRowNames to false.');
    end
    % Prepend row names to each row
    data = [rowNames, data];
    varNames = ['RowName', varNames];
    nCols = nCols + 1;
end

% Determine column formats
if isempty(fixedWidth)
    % Delimited mode
    if isempty(userFormat)
        % Auto format: numbers with default, strings as %s
        colFormats = cell(1, nCols);
        for j = 1:nCols
            if any(cellfun(@isnumeric, data(:,j))) && ~any(cellfun(@ischar, data(:,j)))
                colFormats{j} = '%g';
            else
                colFormats{j} = '%s';
            end
        end
    else
        % User provided a single format for all numeric columns
        colFormats = cell(1, nCols);
        for j = 1:nCols
            if any(cellfun(@isnumeric, data(:,j)))
                colFormats{j} = userFormat;
            else
                colFormats{j} = '%s';
            end
        end
    end
    % Build format string
    formatLine = strjoin(colFormats, delim);
    formatLine = [formatLine, '\n'];
else
    % Fixed width mode – ignore delimiter
    if length(fixedWidth) ~= nCols
        error('FixedWidth vector must have one entry per column (got %d, need %d).', ...
              length(fixedWidth), nCols);
    end
    % Build format specifiers for fixed width (left‑align text, right‑align numbers)
    colFormats = cell(1, nCols);
    for j = 1:nCols
        if any(cellfun(@isnumeric, data(:,j)))
            colFormats{j} = sprintf('%%%d.0f', fixedWidth(j));
        else
            colFormats{j} = sprintf('%%-%ds', fixedWidth(j));
        end
    end
    formatLine = strjoin(colFormats, '');
    formatLine = [formatLine, '\n'];
end

% Escape delimiter if it contains special characters for fprintf
if ~isempty(delim) && ~strcmp(delim, '\t') && ~strcmp(delim, ' ')
    delim = strrep(delim, '%', '%%');
end

% Helper to quote strings if requested
quoteIfNeeded = @(x) quoteAndEscape(x, quote);

% Open file
fid = fopen(filename, 'w', 'n', encoding);
if fid == -1
    error('Cannot open file for writing: %s', filename);
end

% Write variable names (headers)
if writeVarNames
    line = '';
    for j = 1:nCols
        field = varNames{j};
        if quote
            field = ['"' strrep(field, '"', '""') '"'];
        end
        if isempty(fixedWidth)
            if j > 1, line = [line, delim]; end
            line = [line, field];
        else
            if j == 1
                line = sprintf(repmat('%-*s', 1, length(fixedWidth)), fixedWidth, field);
            else
                % For fixed width, we need to concatenate carefully
                % Simpler: build with loop
            end
        end
    end
    if isempty(fixedWidth)
        fprintf(fid, '%s\n', line);
    else
        % Fixed width headers
        for j = 1:nCols
            fprintf(fid, sprintf('%%-%ds', fixedWidth(j)), varNames{j});
        end
        fprintf(fid, '\n');
    end
end

% Write data rows
for i = 1:nRows
    if isempty(fixedWidth)
        % Delimited mode
        rowCells = data(i,:);
        formatted = cell(1, nCols);
        for j = 1:nCols
            val = rowCells{j};
            if isempty(val)
                formatted{j} = '';
            elseif isnumeric(val)
                formatted{j} = sprintf(colFormats{j}, val);
            elseif islogical(val)
                formatted{j} = sprintf('%d', val);
            else % char or string
                str = char(val);
                if quote
                    str = ['"' strrep(str, '"', '""') '"'];
                end
                formatted{j} = str;
            end
        end
        fprintf(fid, formatLine, formatted{:});
    else
        % Fixed width mode
        for j = 1:nCols
            val = data{i,j};
            if isempty(val)
                str = '';
            elseif isnumeric(val)
                str = sprintf(colFormats{j}, val);
            elseif islogical(val)
                str = sprintf('%d', val);
            else
                str = char(val);
                if length(str) > fixedWidth(j)
                    str = str(1:fixedWidth(j));
                elseif quote
                    str = ['"' strrep(str, '"', '""') '"'];
                end
            end
            fprintf(fid, colFormats{j}, str);
        end
        fprintf(fid, '\n');
    end
end

fclose(fid);
fprintf('Wrote table (%d rows, %d columns) to %s\n', nRows, nCols, filename);

end

function out = quoteAndEscape(x, doQuote)
    if ~doQuote || isempty(x)
        out = x;
        return;
    end
    if ischar(x) || isstring(x)
        s = char(x);
        s = strrep(s, '"', '""');
        out = ['"' s '"'];
    else
        out = x;
    end
end