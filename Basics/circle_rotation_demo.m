%% CIRCLE_ROTATION_DEMO
% This script draws lines connecting points on a unit circle to the same
% points after a rotation by an angle alpha. It demonstrates:
%   - Parametric representation of a circle
%   - Rotation transformation (addition of angles)
%   - Basic MATLAB graphics and animation
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up Workspace and Command Window
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace
close all;           % Close any open figure windows

%% 1. Get User Input with Validation
% Number of points around the circle (must be a positive integer)
n = input('Please enter the number of points on the circle (positive integer): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,1) ~= 0
    error('Input must be a positive integer (e.g., 10, 20, 50).');
end

% Rotation angle alpha (in radians) – can be any real number
alpha = input('Please enter the rotation angle alpha (in radians, e.g., pi/4): ');
if ~isscalar(alpha) || ~isnumeric(alpha)
    error('Alpha must be a numeric scalar (e.g., 0.5, pi/3).');
end

fprintf('\nGenerating %d points and rotating by %.3f radians...\n', n, alpha);

%% 2. Compute Points on the Unit Circle
% theta: equally spaced angles from 0 to 2*pi
theta = linspace(0, 2*pi, n);

% Original points (on the unit circle)
x_orig = cos(theta);
y_orig = sin(theta);

% Rotated points: adding alpha to the angle corresponds to a rotation
% by alpha around the origin.
x_rot = cos(theta + alpha);
y_rot = sin(theta + alpha);

%% 3. Create the Figure and Set Up the Axes
figure('Name', 'Circle Rotation Demo', 'NumberTitle', 'off');
hold on;
axis equal;                     % Equal scaling for x and y axes
axis([-1.1 1.1 -1.1 1.1]);     % Fixed limits with a small margin
grid on;                        % Show grid for easier reading
box on;                         % Enclose the axes

% Labels and title
xlabel('X-axis');
ylabel('Y-axis');
title(sprintf('Lines connecting original points to points rotated by \\alpha = %.3f rad', alpha));

% Optional: draw the unit circle as a reference (dashed line)
circle_theta = linspace(0, 2*pi, 200);
plot(cos(circle_theta), sin(circle_theta), 'r--', 'LineWidth', 1, 'DisplayName', 'Unit circle');

%% 4. Animate the Lines (One by One) or Plot All at Once
% Pre-generate random colors for each line (more consistent than rand inside loop)
colors = rand(n, 3);    % Each row: [R, G, B]

fprintf('Drawing the lines...\n');

% Option 1: Animate with a small pause (choose 'y' or 'n')
animate = input('\nAnimate the lines one by one? (y/n, default = n): ', 's');
if strcmpi(animate, 'y')
    for ii = 1:n
        % Plot the ii-th line: from original to rotated point
        plot([x_orig(ii), x_rot(ii)], [y_orig(ii), y_rot(ii)], ...
             'Color', colors(ii, :), 'LineWidth', 1.2);
        % Pause briefly to create animation effect
        pause(0.05);
    end
else
    % Plot all lines at once (much faster, cleaner final result)
    for ii = 1:n
        plot([x_orig(ii), x_rot(ii)], [y_orig(ii), y_rot(ii)], ...
             'Color', colors(ii, :), 'LineWidth', 1.2);
    end
    % The plot appears instantly after the loop
end

%% 5. Final Adjustments
% Mark the points (optional: plot small circles at origins and rotated positions)
plot(x_orig, y_orig, 'bo', 'MarkerSize', 4, 'MarkerFaceColor', 'b', 'DisplayName', 'Original points');
plot(x_rot, y_rot, 'ro', 'MarkerSize', 4, 'MarkerFaceColor', 'r', 'DisplayName', 'Rotated points');

% Add a legend
legend('show', 'Location', 'best');
hold off;

fprintf('\nDone! The figure shows chords connecting original points to their rotated copies.\n');
fprintf('Mathematical note: Rotation by alpha maps (cosθ, sinθ) to (cos(θ+α), sin(θ+α)).\n');