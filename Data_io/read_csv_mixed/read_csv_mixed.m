function [T, numArray, txtArray] = read_csv_mixed(filename, varargin)
% READ_CSV_MIXED Read a CSV file containing mixed data types and missing values.
%   T = READ_CSV_MIXED(FILENAME) reads the CSV file and returns a table.
%   It automatically handles:
%       - Mixed numeric and text columns
%       - Missing entries (empty cells, 'NaN', 'NA', 'null')
%       - Variable names from the first row (if present)
%
%   [T, NUMARRAY, TXTARRAY] = READ_CSV_MIXED(FILENAME) additionally returns
%   two cell arrays: NUMARRAY contains numeric data (with NaNs for missing or
%   non-numeric entries), and TXTARRAY contains the raw text from every cell.
%
%   Optional name-value pairs:
%       'TreatAsMissing'  - Additional strings to treat as missing (cell array)
%       'PreserveVarNames' - Keep original column names exactly (default true)
%       'HeaderLines'      - Number of header lines to skip (default 0)
%
%   Example:
%       % Create a sample CSV file (you can skip this in real use)
%       sampleData = {'Name','Age','Score','Comment';
%                     'Alice','25','92.5','good';
%                     'Bob','','78','';
%                     'Charlie','30','NaN','late';
%                     'Diana','28','88.2','"very good"'};
%       writecell(sampleData, 'sample_mixed.csv');
%
%       % Read the file
%       T = read_csv_mixed('sample_mixed.csv')
%
%   See also READTABLE, DETECTIMPORTOPTIONS, WRITECELL

% Parse inputs
p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addParameter(p, 'TreatAsMissing', {}, @iscell);
addParameter(p, 'PreserveVarNames', true, @islogical);
addParameter(p, 'HeaderLines', 0, @(x) isnumeric(x) && x>=0);
parse(p, filename, varargin{:});

filename = p.Results.filename;
treatAsMissing = p.Results.TreatAsMissing;
preserveVarNames = p.Results.PreserveVarNames;
headerLines = p.Results.HeaderLines;

% Start with default missing strings
defaultMissing = {'NaN', 'NA', 'null', ''};  % empty cell is treated as missing
allMissing = [defaultMissing, treatAsMissing];

% Detect import options
opts = detectImportOptions(filename);

% Force all columns to be read as text initially (to capture raw values)
for i = 1:numel(opts.VariableNames)
    opts = setvartype(opts, opts.VariableNames{i}, 'string');
end

% Skip header lines if needed
if headerLines > 0
    opts.DataLines = [headerLines+1, Inf];
end

% Read everything as strings
rawTable = readtable(filename, opts);

% Convert to cell array for per-cell processing
rawCell = table2cell(rawTable);

% Prepare output arrays
numArray = nan(size(rawCell));
txtArray = cell(size(rawCell));

% Process each cell
for i = 1:size(rawCell, 1)
    for j = 1:size(rawCell, 2)
        val = rawCell{i,j};
        
        % Store the raw text (convert missing to empty string)
        if ismissing(val) || (isstring(val) && strlength(val)==0)
            txtArray{i,j} = '';
        else
            txtArray{i,j} = char(val);
        end
        
        % Try to convert to numeric
        if ismissing(val) || (isstring(val) && (strlength(val)==0 || any(strcmpi(char(val), allMissing))))
            numArray(i,j) = NaN;
        else
            numVal = str2double(char(val));
            if isnan(numVal)
                % Not a number – keep NaN
                numArray(i,j) = NaN;
            else
                numArray(i,j) = numVal;
            end
        end
    end
end

% Build the output table
% Use variable names from rawTable (original headers, possibly cleaned)
varNames = rawTable.Properties.VariableNames;
if preserveVarNames
    % Keep exactly as read (may have spaces, etc.)
else
    % Make valid MATLAB identifiers (optional)
    varNames = matlab.lang.makeValidName(varNames);
end

T = table();
for j = 1:size(numArray, 2)
    % Decide column type: if any non-NaN numeric value exists, treat column as numeric
    if any(~isnan(numArray(:,j)))
        T.(varNames{j}) = numArray(:,j);
    else
        % All NaN -> keep as text (but trim empty strings)
        colText = txtArray(:,j);
        emptyIdx = cellfun(@isempty, colText);
        colText(emptyIdx) = {''};
        T.(varNames{j}) = colText;
    end
end

% If only one output requested, do not return the arrays
if nargout < 2
    clear numArray txtArray
end

end