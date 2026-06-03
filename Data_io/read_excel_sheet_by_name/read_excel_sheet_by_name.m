function data = read_excel_sheet_by_name(filename, sheetName, varargin)
% READ_EXCEL_SHEET_BY_NAME Read a specific worksheet from an Excel file by its name.
%   DATA = READ_EXCEL_SHEET_BY_NAME(FILENAME, SHEETNAME) reads the worksheet
%   named SHEETNAME from the Excel file FILENAME and returns a table.
%
%   DATA = READ_EXCEL_SHEET_BY_NAME(FILENAME, SHEETNAME, 'Range', RANGE)
%   reads only the specified cell range (e.g., 'A1:C10').
%
%   DATA = READ_EXCEL_SHEET_BY_NAME(FILENAME, SHEETNAME, 'PreserveVariableNames', true)
%   keeps the original column headers exactly as they appear (default true).
%
%   Additional name‑value pairs are passed directly to READTABLE (e.g., 'TreatAsMissing').
%
%   Example:
%       % Read sheet named 'SalesData' from an Excel file
%       T = read_excel_sheet_by_name('report.xlsx', 'SalesData')
%
%       % Read only a specific range from sheet 'Summary'
%       T = read_excel_sheet_by_name('report.xlsx', 'Summary', 'Range', 'B2:D20')
%
%   See also READTABLE, XLSFINFO, SHEETNAMES

% Parse required inputs
p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'sheetName', @(x) ischar(x) || isstring(x));
addParameter(p, 'Range', '', @ischar);
addParameter(p, 'PreserveVariableNames', true, @islogical);
% Allow any other parameter to be passed to readtable
parse(p, filename, sheetName, varargin{:});

filename = char(p.Results.filename);
sheetName = char(p.Results.sheetName);
userRange = p.Results.Range;
preserveNames = p.Results.PreserveVariableNames;

% Get all sheet names from the file
try
    % Use sheetnames (R2019b+) if available, otherwise fallback to xlsfinfo
    if exist('sheetnames', 'file')
        sheets = sheetnames(filename);
    else
        [~, sheets] = xlsfinfo(filename);
        if isempty(sheets)
            error('Could not read sheet names from "%s".', filename);
        end
    end
catch
    error('Unable to read Excel file "%s". Check that the file exists and is not corrupted.', filename);
end

% Check if the requested sheet exists
if ~any(strcmp(sheets, sheetName))
    error('Sheet "%s" not found. Available sheets: %s', ...
          sheetName, strjoin(sheets, ', '));
end

% Build options for readtable
opts = detectImportOptions(filename, 'Sheet', sheetName);

if preserveNames
    % Keep original variable names (may contain spaces, special chars)
    opts.PreserveVariableNames = true;
end

% Override range if provided
if ~isempty(userRange)
    opts.DataRange = userRange;
end

% Read the sheet using readtable
try
    data = readtable(filename, opts, 'Sheet', sheetName);
    fprintf('Successfully read sheet "%s" (%d rows, %d columns).\n', ...
            sheetName, height(data), width(data));
catch ME
    error('Failed to read sheet "%s": %s', sheetName, ME.message);
end

end