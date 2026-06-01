%% MATLAB Camera Animation: Flying Around the Peaks Surface
% This script creates a 3D surface of the built-in 'peaks' function and
% animates the camera moving along the x-axis to create a "flyby" effect.

% Clean up workspace and prepare the figure
clear; close all; clc;

%% Create the surface
surf(peaks);
axis vis3d off;      % Keep aspect ratio, turn off axes
colormap(jet);       % Optional: vibrant colormap for better visual effect

%% Set up lighting (enhances depth perception)
light('Position', [1, 1, 1], 'Style', 'infinite');
lighting gouraud;
material dull;

%% Define camera animation parameters
cameraTarget = [25, 38, 8];    % Point the camera looks at (fixed)
yPosition    = 50;              % Constant y-coordinate of camera
zPosition    = 10;              % Constant z-coordinate of camera
xStart       = -200;            % Start x-position
xEnd         = 200;             % End x-position
stepSize     = 5;               % Step size for each frame
pauseTime    = 0.1;             % Pause between frames (seconds)

%% Animate camera movement along the x-axis
fprintf('Starting camera flyby from x = %d to x = %d\n', xStart, xEnd);
for x = xStart:stepSize:xEnd
    % Set camera target (look-at point)
    camtarget(cameraTarget);
    
    % Set camera position (moving only x coordinate)
    campos([x, yPosition, zPosition]);
    
    % Update the display
    drawnow;
    
    % Pause to control animation speed
    pause(pauseTime);
end

fprintf('Animation complete.\n');

% Optional: return to a default view at the end
% view(3);  % Uncomment to reset to default 3D view