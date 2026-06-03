%% ========================================================================
%  ADVANCED STRING‑ART LINE PATTERN GENERATOR
%  ========================================================================
%  This script draws a sequence of straight lines connecting points on the
%  vertical axis (0, b_k) to points on the horizontal axis (a_k, 0), where
%  a_k and b_k are taken from a linearly spaced vector between 0 and 1.
%  Specifically, if x = linspace(0,1,n), then the k‑th line goes from
%  (0, x(end‑k+1)) to (x(k), 0).  The result is a beautiful curved envelope
%  (a quadratic Bézier curve) that becomes smoother as n increases.
%
%  The equation of each line is:   x / a_k  +  y / b_k  = 1.
%  The envelope of the family of lines (for a_k = b_k) is the parabola
%  (x - y)^2 = 2(x + y) - 1  (after appropriate scaling).
%
%  USAGE:
%    Run the script.  When prompted, enter an integer n >= 2.
%    The script will then draw the lines one by one with a short pause.
% =========================================================================

clc; clear all; close all;

% -------------------------------------------------------------------------
% 1. USER INPUT WITH VALIDATION
% -------------------------------------------------------------------------
% Ask for number of lines (n).  Default to 20 if input is invalid.
default_n = 20;
prompt = sprintf('Enter number of lines (positive integer, >=2) [default = %d]: ', default_n);
n = input(prompt);

% Validate input: must be a scalar, positive integer >= 2
if isempty(n) || ~isscalar(n) || ~isnumeric(n) || n < 2 || mod(n,1) ~= 0
    fprintf('Invalid input. Using default n = %d.\n', default_n);
    n = default_n;
end

% -------------------------------------------------------------------------
% 2. PREPARE COORDINATES AND FIGURE
% -------------------------------------------------------------------------
% Points on the axes: equally spaced from 0 to 1.
x_points = linspace(0, 1, n);

% Create a new figure with custom size and white background
figure('Name', 'String‑Art Pattern', 'NumberTitle', 'off', ...
       'Color', 'white', 'Position', [100 100 600 600]);

% Set up axes: square, with a small margin around [0,1]×[0,1]
axis([-0.1 1.2 -0.1 1.2]);
axis square;
grid on;
hold on;

% Labels and title
xlabel('x axis', 'FontSize', 12);
ylabel('y axis', 'FontSize', 12);
title('Building the Envelope of Lines', 'FontSize', 14, 'FontWeight', 'bold');

% Use a colormap (e.g., autumn) to assign colours sequentially.
% This is more visually appealing than pure random colours.
colormap(autumn(n));
color_cycle = colormap;   % n×3 matrix of RGB values

% -------------------------------------------------------------------------
% 3. DRAW LINES ONE BY ONE WITH ANIMATION
% -------------------------------------------------------------------------
% Pre‑allocate graphics handles (optional, useful if we later want to modify)
line_handles = gobjects(1, n);

fprintf('Drawing %d lines ...\n', n);
tic;   % start timer

for k = 1:n
    % Indices:
    %   a = x_points(k)          → x‑intercept (on horizontal axis)
    %   b = x_points(end - k + 1) → y‑intercept (on vertical axis)
    a = x_points(k);
    b = x_points(end - k + 1);
    
    % Coordinates of the line: from (0, b) to (a, 0)
    x_coords = [0, a];
    y_coords = [b, 0];
    
    % Plot the line with a marker at the end points (optional)
    % Use a colour from the colormap, a thin line width, and a small marker.
    line_handles(k) = plot(x_coords, y_coords, '-s', ...
        'Color', color_cycle(k, :), ...
        'LineWidth', 1.2, ...
        'MarkerSize', 3, ...
        'MarkerFaceColor', color_cycle(k, :), ...
        'MarkerEdgeColor', 'k');
    
    % Update the title to show progress
    title(sprintf('Line %d of %d  (a = %.3f, b = %.3f)', k, n, a, b), ...
          'FontSize', 12, 'FontWeight', 'normal');
    
    % Pause a little to create the animation effect.
    % Use drawnow to flush the graphics buffer.
    pause(0.1);
    drawnow;
end

% -------------------------------------------------------------------------
% 4. FINAL TOUCHES
% -------------------------------------------------------------------------
elapsed = toc;
fprintf('Finished in %.2f seconds.\n', elapsed);

% Add a legend (optional – shows first, middle, and last line for clarity)
if n >= 3
    legend([line_handles(1), line_handles(round(n/2)), line_handles(n)], ...
           {'First line', 'Middle line', 'Last line'}, ...
           'Location', 'best', 'FontSize', 10);
end

% Optionally save the final figure as an image file
save_fig = input('\nSave final figure as "string_art.png"? (y/n) [n]: ', 's');
if strcmpi(save_fig, 'y')
    exportgraphics(gcf, 'string_art.png', 'Resolution', 300);
    fprintf('Figure saved as string_art.png\n');
end

hold off;