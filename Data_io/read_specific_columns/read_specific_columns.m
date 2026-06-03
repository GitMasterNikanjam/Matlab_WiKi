function data = read_specific_columns(filename, columns, varargin)
% READ_SPECIFIC_COLUMNS Read only selected columns from a CSV or Excel file.
%
%   DATA = READ_SPECIFIC_COLUMNS(FILENAME, COLUMNS) reads the file and
%   returns a table with only the columns specified in COLUMNS.
%
%   COLUMNS can be:
%       - cell array of column names (e.g., {'Name','Age'})
%       - vector of column indices (e.g., [1,3,5])
%       - string array (e.g., ["Name","Score"])
%
%   Optional name-value pairs:
%       'Sheet'               - Excel sheet name or index (default: 1)
%       'Range'               - Cell range (e.g., 'A1:C100')
%       'ReadVariableNames'   - true if first row contains headers (default: true)
%       'VariableNamingRule'  - 'preserve' (default) or 'modify'
%       Any other option accepted by READTABLE.
%
%   Examples:
%       T = read_specific_columns('data.csv', {'Name','Score'});
%       T = read_specific_columns('data.xlsx', [1,4,6], 'Sheet', 'Sheet2');
%
%   See also READTABLE, DETECTIMPORTOPTIONS

p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'columns', @(x) iscell(x) || isnumeric(x) || isstring(x));
addParameter(p, 'Sheet', 1);
addParameter(p, 'Range', '');
addParameter(p, 'ReadVariableNames', true, @islogical);
addParameter(p, 'VariableNamingRule', 'preserve');
parse(p, filename, columns, varargin{:});

filename = char(p.Results.filename);
columns = p.Results.columns;
sheet = p.Results.Sheet;
range = p.Results.Range;
readVarNames = p.Results.ReadVariableNames;
varNamingRule = p.Results.VariableNamingRule;

% Detect import options
isExcel = contains(lower(filename), '.xlsx') || contains(lower(filename), '.xls');
if isExcel
    opts = detectImportOptions(filename, 'Sheet', sheet);
else
    opts = detectImportOptions(filename);
end

% Set header behaviour
if readVarNames
    % Tell import options that first row contains variable names
    if isExcel
        opts.VariableNamesRow = 1;
    else
        % For text files, use VariableNamesLine (if available) or rely on ReadVariableNames
        if isprop(opts, 'VariableNamesLine')
            opts.VariableNamesLine = 1;
        else
            % Older MATLAB: set 'ReadVariableNames' property directly
            opts.ReadVariableNames = true;
        end
    end
else
    if isExcel
        opts.VariableNamesRow = 0;
    else
        if isprop(opts, 'VariableNamesLine')
            opts.VariableNamesLine = 0;
        else
            opts.ReadVariableNames = false;
        end
    end
end

% Apply range if given
if ~isempty(range)
    opts.DataRange = range;
end

% Get actual variable names (after header detection)
if readVarNames
    % Temporarily read just the first data row to get variable names
    tempOpts = opts;
    if isExcel
        tempOpts.DataRange = '1:1';
    else
        tempOpts.DataLines = [1, 1];
    end
    try
        tempTable = readtable(filename, tempOpts);
        allVars = tempTable.Properties.VariableNames;
    catch
        % Fallback to opts.VariableNames
        allVars = opts.VariableNames;
    end
else
    allVars = opts.VariableNames;
end

% Determine which columns to keep
if isnumeric(columns)
    % Column indices
    if max(columns) > length(allVars)
        error('Column index %d exceeds total columns (%d).', max(columns), length(allVars));
    end
    keepVars = allVars(columns);
elseif isstring(columns) || iscell(columns)
    % Column names
    colsStr = string(columns);
    keepVars = {};
    for i = 1:length(colsStr)
        idx = find(strcmp(allVars, colsStr(i)), 1);
        if isempty(idx)
            error('Column "%s" not found. Available columns: %s', ...
                  colsStr(i), strjoin(allVars, ', '));
        end
        keepVars{end+1} = allVars{idx};
    end
else
    error('COLUMNS must be a cell/string array of names or numeric indices.');
end

% Set selected variables
opts.SelectedVariableNames = keepVars;

% Preserve variable names if requested
if strcmp(varNamingRule, 'preserve') && isprop(opts, 'PreserveVariableNames')
    opts.PreserveVariableNames = true;
end

% Adjust data lines to skip header row if we read it separately
if readVarNames
    if isExcel
        opts.DataRange = [2, Inf];  % start after header row
    else
        if isprop(opts, 'DataLines')
            opts.DataLines = [2, Inf];
        end
    end
end

% Read the data
try
    if isExcel
        data = readtable(filename, opts, 'Sheet', sheet);
    else
        data = readtable(filename, opts);
    end
    fprintf('Read %d rows, %d columns from %s\n', height(data), width(data), filename);
catch ME
    error('Failed to read file: %s', ME.message);
end

end