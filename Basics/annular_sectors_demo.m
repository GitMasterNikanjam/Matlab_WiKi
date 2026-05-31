%% ANNULAR_SECTORS_DEMO (Fixed Visibility)
% Creates alternating black/white annular sectors. 
% FIXES: White sectors now visible on a dark background, plus thin black edges.

clc; clear variables; close all;

%% 1. User Input with Validation
n = input('Please enter the number of angular segments (positive even integer): ');
if ~isscalar(n) || ~isnumeric(n) || n <= 0 || mod(n,2) ~= 0
    error('n must be a positive even integer (e.g., 8, 12, 20).');
end

m = input('Please enter the number of concentric rings (positive integer): ');
if ~isscalar(m) || ~isnumeric(m) || m <= 0 || mod(m,1) ~= 0
    error('m must be a positive integer (e.g., 3, 5, 10).');
end

fprintf('\nCreating %d angular segments over %d rings...\n', n, m);

%% 2. Angular Boundaries
theta = linspace(0, 2*pi, n+1);

%% 3. Set Up Figure with Dark Background (so white sectors pop)
fig = figure('Name', 'Annular Sectors Demo', 'NumberTitle', 'off');
set(fig, 'Color', [0.2, 0.2, 0.2]);  % Dark gray background
hold on;
axis equal;
axis([-(m+0.2) m+0.2 -(m+0.2) m+0.2]);
axis on;          % Show axes temporarily – you can turn off later
grid off;
title(sprintf('Alternating Sectors: %d segments, %d rings', n, m));

%% 4. Colors: black and white (now both visible on dark background)
colors = ['k', 'w'];

%% 5. Animation Toggle
animate = input('\nAnimate each sector? (y/n, default = n): ', 's');
use_pause = strcmpi(animate, 'y');
if use_pause
    fprintf('Rendering with animation (slow).\n');
else
    fprintf('Rendering final result directly (fast).\n');
end

%% 6. Nested Loops: Draw Sectors
for seg = 1:n
    start_angle = theta(seg);
    end_angle   = theta(seg+1);
    
    % Fine angular steps for smooth arcs
    k = start_angle : 0.05 : end_angle;      % inner arc (forward)
    p = end_angle   : -0.05 : start_angle;   % outer arc (backward)
    
    % Alternating color: seg=1->black, seg=2->white, seg=3->black, ...
    color_idx = rem(seg + 1, 2) + 1;   % 1 for 'k', 2 for 'w'
    sector_color = colors(color_idx);
    
    for ring = 1:m
        r_in  = ring - 1;
        r_out = ring;
        
        % Build polygon vertices: inner arc then outer arc (closes radial edges)
        x_poly = [r_in * cos(k), r_out * cos(p)];
        y_poly = [r_in * sin(k), r_out * sin(p)];
        
        % Draw filled sector with a thin black edge for definition
        fill(x_poly, y_poly, sector_color, 'EdgeColor', 'k', 'LineWidth', 0.5);
        
        if use_pause
            pause(0.001);
            drawnow;   % Force screen update
        end
    end
end

%% 7. Final Touches
% Draw outer boundary for clarity
theta_circle = linspace(0, 2*pi, 300);
plot(m * cos(theta_circle), m * sin(theta_circle), 'w-', 'LineWidth', 2);

hold off;
axis off;   % Now you can turn axes off – the pattern is clearly visible

fprintf('\nDone! The figure shows alternating black/white sectors.\n');
fprintf('(Dark background ensures white sectors are visible.)\n');