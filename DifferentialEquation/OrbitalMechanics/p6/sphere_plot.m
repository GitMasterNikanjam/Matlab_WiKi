%% EF 105 MATLAB Plotting Example: Hemisphere with Image Texture
% This script creates a 3D hemisphere (upper half of a sphere) and maps an
% image texture onto it. If 'stars.jpg' is not found, a default MATLAB
% image ('peppers.png') is used automatically.

% Clean up workspace and environment
clear; close all; clc; format compact;

%% Parameters
radius  = 5;       % Radius of the sphere (R)
quality = 100;     % Mesh resolution (higher = smoother surface)

%% Generate sphere coordinates
[x, y, z] = sphere(quality);

% Scale to desired radius
x = radius * x;
y = radius * y;
z = radius * z;

% Keep only the upper hemisphere (z > 0) by setting lower part to NaN
z(z <= 0) = NaN;

%% Load image texture (with fallback to MATLAB default)
imageFile = 'stars.jpg';
if exist(imageFile, 'file') == 2
    img = imread(imageFile);
else
    % Fallback to a built-in MATLAB image (requires Image Processing Toolbox)
    defaultImage = 'peppers.png';
    if exist(defaultImage, 'file') == 2
        img = imread(defaultImage);
        fprintf('Note: "%s" not found. Using "%s" instead.\n', imageFile, defaultImage);
    else
        % Ultra-fallback: create a simple checkerboard texture
        warning('Neither "%s" nor "%s" found. Using checkerboard texture.', imageFile, defaultImage);
        [rows, cols] = size(x);
        checker = uint8(255 * (mod(floor((0:cols-1)/10) + floor((0:rows-1)'/10), 2) == 0));
        img = cat(3, checker, checker, checker);  % RGB checkerboard
    end
end

%% Create the mesh plot with texture mapping
figure('Name', 'Hemisphere with Image Texture', 'NumberTitle', 'off');
h = mesh(x, y, z);
set(h, 'CData', img, 'FaceColor', 'texturemap', 'EdgeColor', 'none');

%% Enhance visualization
axis equal;         % Preserve data aspect ratio
axis off;           % Remove axes for a clean look
view(45, 30);       % Azimuth 45°, elevation 30°
grid off;           % Disable grid

% Optional lighting for better depth perception (texturemap still works)
light('Position', [1, 1, 1], 'Style', 'infinite');
lighting gouraud;
material dull;

% Title
title('Hemisphere with Image Texture', 'FontSize', 12, 'FontWeight', 'bold');

drawnow;