function out = read_text_file_lines(filename, processFunc, varargin)
% READ_TEXT_FILE_LINES Process a large text file line by line.
%   OUT = READ_TEXT_FILE_LINES(FILENAME, PROCESSFUNC) reads the text file
%   line by line, applies the function handle PROCESSFUNC to each line,
%   and collects the results in a cell array OUT.
%
%   PROCESSFUNC must accept a single string input (the current line) and
%   return any output (e.g., processed data, a flag, or empty []).
%
%   Optional name-value pairs:
%       'Encoding'    - Character encoding (default: 'UTF-8').
%       'SkipEmpty'   - Skip empty lines (default: true).
%       'MaxLines'    - Maximum number of lines to read (default: Inf).
%       'HeaderLines' - Number of lines to skip at the beginning (default: 0).
%       'OutputFormat' - 'cell' (default) or 'table' – format of output.
%
%   Examples:
%       % Count lines containing the word 'error'
%       count = 0;
%       read_text_file_lines('log.txt', @(line) ...
%           (contains(line, 'error') && (count = count + 1)));
%
%       % Extract timestamps from a log file
%       timestamps = read_text_file_lines('log.txt', @(line) ...
%           extractBetween(line, '[', ']'));
%
%       % Read first 100 lines of a CSV as strings
%       first100 = read_text_file_lines('data.csv', @(x) x, 'MaxLines', 100);
%
%   See also FOPEN, FGETL, FCLOSE

% Parse inputs
p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'processFunc', @(x) isa(x, 'function_handle'));
addParameter(p, 'Encoding', 'UTF-8', @ischar);
addParameter(p, 'SkipEmpty', true, @islogical);
addParameter(p, 'MaxLines', Inf, @(x) isnumeric(x) && isscalar(x) && x > 0);
addParameter(p, 'HeaderLines', 0, @(x) isnumeric(x) && isscalar(x) && x >= 0);
addParameter(p, 'OutputFormat', 'cell', @(x) ismember(x, {'cell', 'table'}));
parse(p, filename, processFunc, varargin{:});

filename = char(p.Results.filename);
processFunc = p.Results.processFunc;
encoding = p.Results.Encoding;
skipEmpty = p.Results.SkipEmpty;
maxLines = p.Results.MaxLines;
headerLines = p.Results.HeaderLines;
outputFormat = p.Results.OutputFormat;

% Open file
fid = fopen(filename, 'r', 'n', encoding);
if fid == -1
    error('Cannot open file: %s', filename);
end

% Skip header lines
for i = 1:headerLines
    fgetl(fid);
    if feof(fid)
        break;
    end
end

% Process line by line
results = {};
lineCount = 0;
lineNum = headerLines + 1;

while ~feof(fid) && (lineCount < maxLines)
    line = fgetl(fid);
    lineNum = lineNum + 1;
    
    % Skip empty lines if requested
    if skipEmpty && (isempty(line) || all(isspace(line)))
        continue;
    end
    
    try
        outLine = processFunc(line);
        if ~isempty(outLine)
            results{end+1, 1} = outLine; %#ok<AGROW>
        end
    catch ME
        warning('Error processing line %d: %s', lineNum, ME.message);
    end
    
    lineCount = lineCount + 1;
end

fclose(fid);

% Format output
if strcmp(outputFormat, 'table')
    if isempty(results)
        out = table();
    else
        % Try to convert to table (assumes each output is a scalar or row)
        try
            out = cell2table(results, 'VariableNames', {'ProcessedData'});
        catch
            warning('Could not convert output to table, returning cell array.');
            out = results;
        end
    end
else
    out = results;
end

fprintf('Processed %d lines from "%s".\n', lineCount, filename);

end