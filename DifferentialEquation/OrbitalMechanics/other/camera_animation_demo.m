%% CAMERA_ANIMATION_DEMO
% Advanced example: fly around the MATLAB "peaks" surface.
% Features:
%   - Circular camera trajectory (smooth rotation)
%   - Optional spiral (inward/outward) motion
%   - Interactive slider to control camera angle manually
%   - Lighting, colormap, and colorbar for better visualization

clc;
clear variables;
close all;

%% 1. Create the surface with enhanced visuals
figure('Name', 'Peaks Surface Camera Flyby', 'NumberTitle', 'off', 'Color', 'k');
surf(peaks, 'EdgeColor', 'none', 'FaceAlpha', 0.9);
colormap(jet);
colorbar;
axis vis3d off;          % disable automatic axis adjustment, hide axes
grid off;
title('Peaks Surface – Camera Flyby', 'Color', 'w');

% Add lighting for better depth perception
light('Position', [10, 10, 20], 'Style', 'local');
lighting gouraud;
material dull;

% Store the target (center of the surface)
target = [25, 38, 8];    % center of the peaks data
camtarget(target);

%% 2. Define a smooth camera path (circular in X‑Y, with optional Z variation)
radius = 250;            % distance from target
n_frames = 200;          % number of frames in the full loop
angles = linspace(0, 2*pi, n_frames);   % complete circle

% Camera positions: move in a circle around the target
% Option A: pure circular (constant height)
cam_x = target(1) + radius * cos(angles);
cam_y = target(2) + radius * sin(angles);
cam_z = repmat(50, size(cam_x));   % fixed height

% Option B: spiral (uncomment to use)
% cam_z = 50 + 20 * sin(angles * 2);   % up‑and‑down motion

% Precompute camera positions as a matrix
camera_positions = [cam_x; cam_y; cam_z]';

%% 3. Animation: move camera along the path
fprintf('Starting camera flyby...\n');
for i = 1:n_frames
    campos(camera_positions(i, :));
    drawnow;
    pause(0.03);        % control animation speed
end
fprintf('Flyby finished.\n');

%% 4. (Optional) Interactive slider to control camera angle manually
% Uncomment the block below to add a slider that lets you
% scrub through the camera angles manually.
%
%   slider_handle = uicontrol('Style', 'slider', ...
%                   'Min', 1, 'Max', n_frames, 'Value', 1, ...
%                   'Position', [20 20 200 20], ...
%                   'Callback', @(h,~) set(campos, camera_positions(round(get(h,'Value')),:)));
%   addlistener(slider_handle, 'Value', 'PostSet', @(~,~) drawnow);
%   fprintf('Use the slider to control camera angle.\n');