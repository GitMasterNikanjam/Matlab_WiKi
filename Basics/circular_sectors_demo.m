%% CIRCULAR_SECTORS_DEMO
% Draws a circle divided into an even number of alternating black and white
% sectors (like a pie chart). Each sector has a smooth curved outer edge.
%
% Author: MATLAB User
% Date:   Current date

%% Clean Up
clc;                 % Clear Command Window
clear variables;     % Remove all variables from workspace
close all;           % Close any open figure windows

%% 1. User Input with Validation
% Number of sectors (must be a positive even integer)
n = input('Please enter the number of sectors (positive even integer): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,2) ~= 0
    error('n must be a positive even integer (e.g., 8, 12, 20).');
end

fprintf('\nCreating %d alternating black/white sectors...\n', n);

%% 2. Angular Boundaries
% Evenly spaced angles from 0 to 2π (n+1 points)
theta = linspace(0, 2*pi, n+1);

%% 3. Set Up Figure with Dark Background
% Dark gray background ensures white sectors are visible.
fig = figure('Name', 'Circular Sectors Demo', 'NumberTitle', 'off');
set(fig, 'Color', [0.2, 0.2, 0.2]);   % Dark gray background
hold on;
axis equal;                           % Equal scaling for x and y
axis([-1.1 1.1 -1.1 1.1]);           % Small margin around the circle
axis off;                             % Clean look – no axes
title(sprintf('Alternating Sectors: %d segments', n));

%% 4. Animation Option
animate = input('\nAnimate each sector? (y/n, default = n): ', 's');
use_pause = strcmpi(animate, 'y');
if use_pause
    fprintf('Rendering with animation (slow).\n');
else
    fprintf('Rendering final result directly (fast).\n');
end

%% 5. Draw Each Sector (True Curved Sectors)
% For each sector from angle theta(ii) to theta(ii+1):
for ii = 1:n
    % Alternating color: even index -> black, odd index -> white
    if rem(ii,2) == 0
        sector_color = 'k';
    else
        sector_color = 'w';
    end
    
    start_angle = theta(ii);
    end_angle   = theta(ii+1);
    
    % Create a finely spaced angle vector for the curved outer edge.
    % Step of 0.01 rad gives a smooth arc (finer than original).
    arc_angles = start_angle : 0.01 : end_angle;
    
    % Build polygon vertices in the correct order:
    %   (1) Center (0,0)
    %   (2) Point on circle at start_angle
    %   (3) Points along the circular arc (curved edge)
    %   (4) Point on circle at end_angle
    % This order traces the boundary of a true sector.
    x_poly = [0, cos(start_angle), cos(arc_angles), cos(end_angle)];
    y_poly = [0, sin(start_angle), sin(arc_angles), sin(end_angle)];
    
    % Fill the sector. A thin black edge separates adjacent sectors.
    fill(x_poly, y_poly, sector_color, 'EdgeColor', 'k', 'LineWidth', 0.5);
    
    % Optional animation: pause briefly and force screen update
    if use_pause
        pause(0.01);
        drawnow;
    end
end

%% 6. Final Touch: Draw the Outer Circle Boundary
% A white circle at radius 1 gives a crisp outer edge.
circle_theta = linspace(0, 2*pi, 300);
plot(cos(circle_theta), sin(circle_theta), 'w-', 'LineWidth', 1.5);

hold off;
fprintf('\nDone! The figure shows %d alternating black and white sectors (true curved edges).\n', n);