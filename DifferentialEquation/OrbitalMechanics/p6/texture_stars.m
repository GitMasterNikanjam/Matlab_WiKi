%% EF 105 MATLAB Plotting Example: 3D Surface with Image Texture
% This script creates a 3D surface defined by a mathematical function and
% maps an image texture onto it. If 'earth.png' is missing, a default MATLAB
% image ('peppers.png') is used automatically.

% Clean up workspace and environment
clear; close all; clc; format compact;

%% Parameters
amplitude = -0.5;   % Scaling factor for surface height (k)
offset    =  0.6;   % Offset to avoid division by zero (j)
gridRes   =  0.2;   % Grid resolution (smaller = finer surface)
xLimits   = [-3, 3];
yLimits   = [-3, 3];

%% Generate grid and compute surface heights
x = xLimits(1):gridRes:xLimits(2);
y = yLimits(1):gridRes:yLimits(2);
[X, Y] = meshgrid(x, y);

rSquared = X.^2 + Y.^2;
Z = amplitude .* (1 - cos(rSquared) ./ (rSquared + offset));

%% Create the surface plot
figure('Name', '3D Surface with Image Texture', 'NumberTitle', 'off');
h = surf(X, Y, Z, 'FaceColor', 'texturemap', 'EdgeColor', 'none');

%% Load and apply image texture (with fallback to MATLAB default)
imageFile = 'earth.png';
if exist(imageFile, 'file') == 2
    img = imread(imageFile);
else
    % Use a default MATLAB image (peppers.png is common in Image Processing Toolbox)
    defaultImage = 'peppers.png';
    if exist(defaultImage, 'file') == 2
        img = imread(defaultImage);
        fprintf('Note: "%s" not found. Using "%s" instead.\n', imageFile, defaultImage);
    else
        % Ultra‑fallback: create a built‑in colormap texture (should never happen)
        warning('Neither "%s" nor "%s" found. Using gradient texture.', imageFile, defaultImage);
        img = repmat(uint8(linspace(0, 255, size(X,2))), size(X,1), 1);
        img = cat(3, img, img, img);  % Convert to RGB
    end
end

set(h, 'CData', img);

%% Enhance visualization
axis equal;         % Preserve data aspect ratio
axis off;           % Remove axes for a clean look
view(45, 30);       % Set azimuth (45°) and elevation (30°)
grid off;           % Disable grid (axes are off anyway)

% Add lighting to improve depth perception (works best without texturemap)
light('Position', [1, 1, 1], 'Style', 'infinite');
lighting gouraud;   % Smooth lighting algorithm
material dull;      % Surface reflectivity

% Optional title
title('3D Surface with Image Texture', 'FontSize', 12, 'FontWeight', 'bold');

% Final rendering
drawnow;