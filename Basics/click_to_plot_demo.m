%% CLICK_TO_PLOT_DEMO
% Interactive figure: clicking on the axes draws a red circle at the
% click location and displays the coordinates in the title.
%
% Features:
%   - Left click: add a point (circle)
%   - Right click: clear all points
%   - Coordinates shown in real time
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up
clc;                 % Clear Command Window
clear variables;     % Clear variables (safer than 'clear all')
close all;           % Close all figure windows

%% Create Figure and Axes
% Create a figure window with a specific name and size
fig = figure('Name', 'Click to Plot Demo', ...
             'NumberTitle', 'off', ...
             'Position', [100, 100, 600, 500]);

% Create axes that fill the figure
ax = axes('Parent', fig, ...
          'Units', 'normalized', ...
          'Position', [0.1, 0.1, 0.8, 0.8], ...
          'Box', 'on', ...
          'XLim', [0 10], ...
          'YLim', [0 10]);

% Set up the axes appearance
grid(ax, 'on');
hold(ax, 'on');
xlabel(ax, 'X axis');
ylabel(ax, 'Y axis');
title(ax, 'Click anywhere on the grid to add a point');

% Store initial state: empty point list
setappdata(ax, 'points', []);   % Store coordinates of all points
setappdata(ax, 'handles', []);  % Store plot handles for deletion

%% Define the Callback Function (nested)
% The callback is triggered when the user clicks on the axes.
% It receives two arguments: the axes handle (src) and event data (evt).

    function aa(src, evt)
        % Get click coordinates in axes units
        clickPoint = get(src, 'CurrentPoint');
        x = clickPoint(1,1);
        y = clickPoint(1,2);
        
        % Get current points and handles from axes application data
        points = getappdata(src, 'points');
        handles = getappdata(src, 'handles');
        
        % Determine click type: left button (normal) or right button (alt)
        selectionType = get(gcf, 'SelectionType');
        
        switch selectionType
            case 'normal'   % Left click: add a point
                % Check if click is within axes limits
                xlims = get(src, 'XLim');
                ylims = get(src, 'YLim');
                if x >= xlims(1) && x <= xlims(2) && ...
                   y >= ylims(1) && y <= ylims(2)
                    
                    % Plot a red circle at the click location
                    h = plot(src, x, y, 'ro', 'MarkerSize', 8, ...
                             'MarkerFaceColor', 'r', ...
                             'Tag', sprintf('point_%d', length(points)+1));
                    
                    % Store the new point and its handle
                    points = [points; x, y];
                    handles = [handles; h];
                    
                    % Update axes title with last click coordinates
                    title(src, sprintf('Last click: (%.2f, %.2f)', x, y));
                else
                    % Click outside limits: ignore but warn
                    title(src, 'Click inside axes limits!');
                    pause(0.5);
                    title(src, 'Click anywhere on the grid to add a point');
                end
                
            case 'alt'      % Right click (or Ctrl+click): clear all points
                % Delete all point markers
                for k = 1:length(handles)
                    if ishandle(handles(k))
                        delete(handles(k));
                    end
                end
                % Reset storage
                points = [];
                handles = [];
                title(src, 'All points cleared. Click to add new points.');
                
            otherwise
                % Middle click or other: do nothing
                disp('Use left button to add, right button to clear.');
        end
        
        % Save updated data back to axes
        setappdata(src, 'points', points);
        setappdata(src, 'handles', handles);
    end

%% Attach the Callback to the Axes
set(ax, 'ButtonDownFcn', @aa);

%% Optional: Add a UI Button to Clear Points
uicontrol('Parent', fig, ...
          'Style', 'pushbutton', ...
          'String', 'Clear All', ...
          'Units', 'normalized', ...
          'Position', [0.4, 0.02, 0.2, 0.05], ...
          'Callback', @(btn, evt) aa(ax, struct('SelectionType','alt')));

fprintf('Interactive plot ready. Left click to add points, right click to clear.\n');