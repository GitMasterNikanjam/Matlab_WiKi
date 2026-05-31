%% SQUARE_CORNER_LINES_DEMO
% This script draws animated lines connecting points along the edges of a
% unit square (from (0,0) to (1,1)). For each step i from 0 to n,
% it draws four lines:
%   1. Bottom-left corner to right edge (descending)
%   2. Left edge to top-right corner (ascending)
%   3. Bottom edge to top-left corner (ascending)
%   4. Top edge to bottom-right corner (descending)
% The result is a dynamic, colorful "curtain" pattern.
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace
close all;           % Close any open figure windows

%% 1. User Input with Validation
% Number of divisions (n) determines how many lines are drawn.
% Must be a positive integer.
n = input('Please enter the number of divisions (positive integer): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,1) ~= 0
    error('n must be a positive integer (e.g., 10, 20, 50).');
end

fprintf('\nDrawing pattern with %d divisions (total lines: %d).\n', n, 4*(n+1));

%% 2. Set Up the Figure
fig = figure('Name', 'Square Corner Lines Demo', 'NumberTitle', 'off');
hold on;
axis([-0.1 1.1 -0.1 1.1]);   % Slight margin around the unit square
axis square;                  % Equal scaling for both axes
axis off;                     % Clean look – no axes labels
title(sprintf('Animated Line Pattern (n = %d)', n));

% Optional: draw the unit square boundary for reference
rectangle('Position', [0 0 1 1], 'EdgeColor', 'k', 'LineWidth', 1.5);

%% 3. Animation Option
animate = input('\nAnimate step by step? (y/n, default = y): ', 's');
use_pause = ~strcmpi(animate, 'n');   % Default to yes if not 'n'
if use_pause
    speed = input('Pause duration between frames (seconds, default = 0.1): ');
    if isempty(speed) || ~isnumeric(speed) || speed < 0
        speed = 0.1;
    end
    fprintf('Animating with %.2f sec pause...\n', speed);
else
    fprintf('Rendering final result directly (no animation).\n');
end

%% 4. Draw the Lines
% Loop over each division index i = 0, 1, ..., n
for i = 0:n
    % Parameter t: fraction from 0 to 1 as i increases.
    % t = 0 -> bottom/left edges; t = 1 -> top/right edges.
    t = i / n;
    
    % --- First family: from bottom-left corner (0,0) to right edge (1, t)
    % Line from (0,0) to (1, t) with descending y?
    % Actually original: plot([0, 1 - t], [t, 0]) 
    % That's from (0, t) to (1-t, 0). Let's keep original but comment.
    x1 = [0, 1 - t];
    y1 = [t, 0];
    plot(x1, y1, '-o', 'Color', rand(1,3), 'LineWidth', 2, ...
         'MarkerSize', 4, 'MarkerFaceColor', 'auto');
    
    % --- Second family: from left edge (t,0) to top-right corner (1,1)
    % Original: plot([t, 1], [0, t]) -> from (t,0) to (1, t)
    x2 = [t, 1];
    y2 = [0, t];
    plot(x2, y2, '-o', 'Color', rand(1,3), 'LineWidth', 2, ...
         'MarkerSize', 4, 'MarkerFaceColor', 'auto');
    
    % --- Third family: from bottom edge (0,t) to top-left corner (0,1)
    % Original: plot([0, 1 - t], [1 - t, 1]) -> from (0, 1-t) to (1-t, 1)
    x3 = [0, 1 - t];
    y3 = [1 - t, 1];
    plot(x3, y3, '-o', 'Color', rand(1,3), 'LineWidth', 2, ...
         'MarkerSize', 4, 'MarkerFaceColor', 'auto');
    
    % --- Fourth family: from top edge (1, t) to bottom-right corner (1,0)
    % Original: plot([1, t], [1 - t, 1]) -> from (1, 1-t) to (t, 1)
    x4 = [1, t];
    y4 = [1 - t, 1];
    plot(x4, y4, '-o', 'Color', rand(1,3), 'LineWidth', 2, ...
         'MarkerSize', 4, 'MarkerFaceColor', 'auto');
    
    % Animation: pause and force screen update
    if use_pause
        pause(speed);
        drawnow;
    end
end

%% 5. Final Touches
hold off;
fprintf('Done! The pattern shows lines connecting points on the square edges.\n');