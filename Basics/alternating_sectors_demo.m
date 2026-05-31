%% ALTERNATING_SECTORS_DEMO
% This script draws a circle divided into an even number of alternating
% black and white sectors (like a pie chart). The sectors radiate from
% the center (0,0) to radius 1.
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace
close all;           % Close any open figure windows

%% 1. User Input with Validation
% Number of sectors must be a positive even integer
n = input('Please enter the number of sectors (positive even integer): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,2) ~= 0
    error('n must be a positive even integer (e.g., 8, 12, 20).');
end

fprintf('\nCreating %d alternating black/white sectors...\n', n);

%% 2. Angular Boundaries
% Evenly spaced angles from 0 to 2π (n+1 points)
theta = linspace(0, 2*pi, n+1);

%% 3. Set Up Figure with Dark Background
% Dark gray background makes white sectors visible.
fig = figure('Name', 'Alternating Sectors Demo', 'NumberTitle', 'off');
set(fig, 'Color', [0.2, 0.2, 0.2]);   % Dark gray background
hold on;
axis equal;                           % Equal scaling for x and y
axis([-1.1 1.1 -1.1 1.1]);           % Small margin around the circle
axis off;                             % No axes – just the pattern
title(sprintf('Alternating Sectors: %d segments', n));

%% 4. Animation Option
animate = input('\nAnimate each sector? (y/n, default = n): ', 's');
use_pause = strcmpi(animate, 'y');
if use_pause
    fprintf('Rendering with animation (slow).\n');
else
    fprintf('Rendering final result directly (fast).\n');
end

%% 5. Draw Each Sector
for ii = 1:n
    % Determine color: even index -> black, odd index -> white
    if rem(ii,2) == 0
        sector_color = 'k';
    else
        sector_color = 'w';
    end
    
    % Angular range for this sector: theta(ii) to theta(ii+1)
    start_angle = theta(ii);
    end_angle   = theta(ii+1);
    
    % Create a finely spaced angle vector for the curved outer edge
    % (step 0.01 rad ensures a smooth arc)
    arc_angles = start_angle : 0.01 : end_angle;
    
    % Build polygon vertices in order:
    %   (1) Center (0,0)
    %   (2) Start point on circle (cos(start_angle), sin(start_angle))
    %   (3) Arc points from start_angle to end_angle (the curved edge)
    %   (4) End point on circle (cos(end_angle), sin(end_angle))
    % This order traces the boundary correctly for a filled sector.
    x_poly = [0, cos(start_angle), cos(arc_angles), cos(end_angle)];
    y_poly = [0, sin(start_angle), sin(arc_angles), sin(end_angle)];
    
    % Fill the sector. Use a thin black edge around each sector for definition.
    fill(x_poly, y_poly, sector_color, 'EdgeColor', 'k', 'LineWidth', 0.5);
    
    % Animation: pause briefly and force screen update
    if use_pause
        pause(0.01);
        drawnow;
    end
end

%% 6. Final Touch: Draw the Outer Boundary
% A white circle at radius 1 makes the pattern complete.
circle_theta = linspace(0, 2*pi, 300);
plot(cos(circle_theta), sin(circle_theta), 'w-', 'LineWidth', 1.5);

hold off;
fprintf('\nDone! The figure shows %d alternating black and white sectors.\n', n);