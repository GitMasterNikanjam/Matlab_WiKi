%% 3D Graphics: Three Spheres with Different Visual Effects
% Author: Based on Dr. P. Venkataraman's example
% This script creates a main figure containing three spheres in nested axes,
% each demonstrating different lighting and transparency techniques.

%% Initialize the figure
clear; close all; clc;
format compact

% Create the main figure with custom appearance
figure('Menubar', 'none', ...
       'Name', 'Spheres', ...
       'NumberTitle', 'off', ...
       'Position', [10, 350, 400, 300], ...
       'Color', [0.2, 0.3, 0.4]);   % Dark blue-gray background

%% Sphere 1: Large background sphere with red interpolated transparency
ax1 = axes('Position', [0, 0, 1, 1], 'Visible', 'off');
[X, Y, Z] = sphere(30);          % Generate sphere coordinates (30x30 faces)

% Create the surface with red color and transparency gradient
sphere1 = surf(ax1, X, Y, Z);
set(sphere1, 'EdgeColor', 'none', ...
             'FaceColor', 'red', ...
             'FaceAlpha', 'interp');   % Transparency varies across surface

% Apply alpha mapping: faces farther from camera become more transparent
alpha color;                      % Use color data to determine transparency
alphamap('rampdown');             % Map transparency values

% Add lighting and shading
camlight(45, 45);                 % Light source at azimuth 45°, elevation 45°
lighting phong;                   % Smooth lighting model
axis(ax1, 'square', 'equal');
hidden off;                       % Show back faces (transparent effect)

%% Sphere 2: Medium sphere with interpolated color and transparency
ax2 = axes('Position', [0.1, 0.1, 0.5, 0.5], 'Visible', 'off');
[X, Y, Z] = sphere(20);           % Coarser mesh for a different look

sphere2 = surf(ax2, X, Y, Z);
set(sphere2, 'EdgeColor', [0.5, 0.5, 0.5], ...   % Gray edges
             'FaceColor', 'interp', ...          % Color varies with z (default)
             'FaceAlpha', 'interp');             % Transparency varies

alpha color;
alphamap('rampdown');
camlight right;                   % Light from the right side
lighting phong;
axis(ax2, 'equal');
hidden off;

%% Sphere 3: Small sphere with custom material properties
ax3 = axes('Position', [0.6, 0.6, 0.3, 0.3], 'Visible', 'off');
[X, Y, Z] = sphere(30);           % Fine mesh for sharp appearance

sphere3 = surf(ax3, X, Y, Z);
set(sphere3, 'EdgeColor', 'none', ...
             'FaceColor', 'y', ...               % Yellow surface
             'FaceLighting', 'phong', ...
             'AmbientStrength', 0.3, ...         % Low ambient reflection
             'DiffuseStrength', 0.8, ...         % Moderate diffuse reflection
             'SpecularStrength', 0.9, ...        % Strong specular highlights
             'SpecularExponent', 25, ...         % Focused highlights
             'BackFaceLighting', 'lit');         % Light both sides

camlight left;                    % Light from the left side
axis(ax3, 'square', 'equal');
hidden off;

%% Final adjustments
% Ensure all axes are invisible (background only)
set([ax1, ax2, ax3], 'Visible', 'off');
drawnow;