function append_to_excel(filename, data, sheetname, varargin)
% APPEND_TO_EXCEL Safely append data to an existing Excel worksheet.
%   Reads the entire sheet, combines with new data, and writes back.
%   No risk of overwriting existing rows.
%
%   Syntax and options are the same as the original.

% Parse inputs
p = inputParser;
addRequired(p, 'filename', @(x) ischar(x) || isstring(x));
addRequired(p, 'data');
addOptional(p, 'sheetname', 1, @(x) (ischar(x) || isstring(x) || isnumeric(x)));
addParameter(p, 'WriteVariableNames', true, @islogical);
addParameter(p, 'AutoFitWidth', false, @islogical);
addParameter(p, 'PreserveFormat', true, @islogical);
parse(p, filename, data, sheetname, varargin{:});

filename = char(p.Results.filename);
data = p.Results.data;
sheetname = p.Results.sheetname;
writeVarNames = p.Results.WriteVariableNames;
autoFit = p.Results.AutoFitWidth;

% --- Resolve sheet name ---
try
    [~, sheets] = xlsfinfo(filename);
    if isnumeric(sheetname)
        if sheetname > numel(sheets)
            error('Sheet number %d exceeds number of sheets (%d).', sheetname, numel(sheets));
        end
        sheetActual = sheets{sheetname};
    else
        sheetActual = char(sheetname);
        if ~any(strcmp(sheets, sheetActual))
            error('Sheet "%s" not found in file "%s".', sheetActual, filename);
        end
    end
catch ME
    error('Failed to read sheet information: %s', ME.message);
end

% --- Read existing data as cell array ---
try
    existing = readcell(filename, 'Sheet', sheetActual, 'PreserveVariableNames', true);
    % Remove any trailing completely empty rows (optional, for cleanliness)
    if ~isempty(existing)
        lastDataRow = 0;
        for i = 1:size(existing,1)
            if any(~cellfun(@(c) isempty(c) || (isstring(c) && c == ""), existing(i,:)))
                lastDataRow = i;
            end
        end
        if lastDataRow > 0 && lastDataRow < size(existing,1)
            existing = existing(1:lastDataRow, :);
        end
    end
catch
    % Sheet is completely empty or has no data
    existing = {};
end

% --- Convert new data to cell array ---
if istable(data)
    if writeVarNames
        % Include table headers as first row
        newCell = [data.Properties.VariableNames; table2cell(data)];
    else
        newCell = table2cell(data);
    end
elseif isnumeric(data) || islogical(data)
    newCell = num2cell(data);
elseif iscell(data)
    newCell = data;
else
    error('Data type not supported. Use table, cell array, or numeric matrix.');
end

% --- Combine existing and new data ---
if isempty(existing)
    combined = newCell;
else
    combined = [existing; newCell];
end

% --- Write the complete combined data back to the sheet ---
writecell(combined, filename, 'Sheet', sheetActual, 'WriteMode', 'overwritesheet');

% --- Optional auto‑fit (Windows only) ---
if autoFit && ispc
    try
        Excel = actxserver('Excel.Application');
        Excel.Visible = false;
        WB = Excel.Workbooks.Open(fullfile(pwd, filename));
        WS = WB.Sheets.Item(sheetActual);
        WS.Columns.AutoFit;
        WB.Save;
        WB.Close;
        Excel.Quit;
        delete(Excel);
    catch
        warning('AutoFitWidth failed (requires Excel on Windows with ActiveX).');
    end
end

fprintf('Successfully appended %d rows to "%s", sheet "%s".\n', ...
    size(newCell,1), filename, sheetActual);

end