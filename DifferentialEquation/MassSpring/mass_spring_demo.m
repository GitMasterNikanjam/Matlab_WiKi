%% MASS_SPRING_DEMO
% Simulates and animates a simple mass‑spring system (undamped).
% Equation of motion:  m * x'' + k * x = 0,  with m = 1, k = 10.
% The displacement is normalized so the maximum amplitude becomes 1.
%
% The animation shows:
%   - a green ground block
%   - a black spring (8 coils)
%   - a black mass (circle)
%
% Author: MATLAB User
% Date:   Current date

%% Clean up
clc;                     % Clear Command Window
clear variables;         % Clear variables (safer than 'clear all')
close all;               % Close all figure windows

%% Simulation parameters
m = 1;                   % mass (kg)
k = 10;                  % spring constant (N/m)
omega = sqrt(k/m);       % natural frequency (rad/s)
t_span = 0:0.02:10;      % time vector (s)
initial_cond = [1.5; 0]; % initial displacement (m) and velocity (m/s)

%% Solve ODE
[T, Y] = ode45(@(t, x) mass_spring_ode(t, x, k, m), t_span, initial_cond);
% Y(:,1) = displacement, Y(:,2) = velocity

%% Normalize displacement for consistent animation range
Y(:,1) = Y(:,1) / max(abs(Y(:,1)));   % scale so max |displacement| = 1

%% Set up the figure window
figure('Name', 'Mass-Spring Oscillator', 'NumberTitle', 'off');
hold on;
axis equal;
axis([-1, 1, -1.9, 0.1]);
grid on;
xlabel('X position (m)');
ylabel('Y position (m)');
title('Animated Mass‑Spring System (undamped)');

%% Draw the ground (green rectangle)
ground = fill([-0.15, 0.15, 0.15, -0.15], [0, 0, 0.1, 0.1], 'g', 'EdgeColor', 'none');
text(0, 0.12, 'Ground', 'HorizontalAlignment', 'center', 'FontSize', 10);

%% Prepare spring geometry
% The spring is drawn as a sine wave with 8 full cycles (16*pi radians)
theta = linspace(0, 16*pi, 500);      % angle for the sine wave
spring_amp = 0.1;                     % horizontal half‑width of the spring

% Initial spring length (based on first displacement)
init_length = -Y(1,1) - 1;            % from ground (y=0) to mass (negative)

% Create spring and mass graphics objects
spring_handle = plot(spring_amp * sin(theta), linspace(0, init_length, length(theta)), ...
                     'k', 'LineWidth', 2);
mass_handle = plot(0, init_length, 'ok', 'MarkerFaceColor', 'k', 'MarkerSize', 15);

%% Animation loop
fprintf('Animating... press Ctrl+C to stop early.\n');
for i = 2:length(T)
    % Current position of the mass (y-coordinate)
    y_mass = -Y(i,1) - 1;
    
    % Update mass position
    set(mass_handle, 'YData', y_mass);
    
    % Update spring: keep same x‑shape, stretch vertically to new length
    spring_length = y_mass;   % negative, because mass is below ground
    set(spring_handle, 'YData', linspace(0, spring_length, length(theta)));
    
    % Force MATLAB to redraw and pause briefly (smooth animation)
    drawnow;
    pause(0.01);              % small delay to control speed
end

fprintf('Animation finished.\n');

%% Local function defining the ODE (mass-spring system)
function dxdt = mass_spring_ode(~, x, k, m)
    % x(1) = displacement, x(2) = velocity
    dxdt = zeros(2,1);
    dxdt(1) = x(2);
    dxdt(2) = - (k/m) * x(1);
end