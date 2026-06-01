%% ORBIT_SIMULATION
% Simulates a planet (or satellite) orbiting a central star under gravity.
% Equations of motion in polar coordinates (theta, r):
%   d(theta)/dt = theta_dot
%   d(r)/dt = r_dot
%   d(theta_dot)/dt = -2 * r_dot * theta_dot / r
%   d(r_dot)/dt = r * theta_dot^2 - GM / r^2
% State vector: [theta; theta_dot; r; r_dot]
% Initial conditions: Earth‑like orbit (circular, radius 1 AU).

clc;
clear variables;   % safer than 'clear all'
close all;

%% 1. Physical constants and initial conditions (SI units)
G = 6.67430e-11;          % gravitational constant (m^3 kg^-1 s^-2)
M_sun = 1.989e30;         % mass of the Sun (kg)
AU = 149.59787e9;         % 1 Astronomical Unit = Earth's mean orbital radius (m)

% Initial state (circular orbit at 1 AU)
theta0 = 0;               % initial angle (rad)
r0 = AU;                  % initial radius (m)
% For a circular orbit, orbital velocity v = sqrt(GM/r) and omega = v/r
omega0 = sqrt(G * M_sun / r0^3);   % initial angular velocity (rad/s)
r_dot0 = 0;               % no radial velocity for circular orbit

initial_state = [theta0; omega0; r0; r_dot0];

%% 2. Simulation time: one full orbital period
T_orbital = 2 * pi / omega0;      % seconds (about 1 year)
t_span = [0, T_orbital];          % simulate exactly one orbit

%% 3. ODE solver options (for accuracy)
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);

%% 4. Solve ODE
[T, Y] = ode45(@orbit_ode, t_span, initial_state, options);
% Y(:,1) = theta, Y(:,2) = theta_dot, Y(:,3) = r, Y(:,4) = r_dot

%% 5. Convert to Cartesian coordinates for plotting
x = Y(:,3) .* cos(Y(:,1));
y = Y(:,3) .* sin(Y(:,1));

%% 6. Set up the figure with animation
figure('Name', 'Orbit Simulation', 'NumberTitle', 'off');
hold on;
grid on;
axis equal;
xlabel('x (m)');
ylabel('y (m)');
title('Planetary Orbit (Central Force)');

% Plot the full trajectory (faint line)
plot(x, y, 'b-', 'LineWidth', 1);

% Mark the central star (Sun)
plot(0, 0, 'yo', 'MarkerSize', 12, 'MarkerFaceColor', 'y');

% Create a marker for the current planet position
planet_marker = plot(x(1), y(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Set axis limits with a margin (10% of the orbital radius)
margin = 0.1 * r0;
xlim([-r0-margin, r0+margin]);
ylim([-r0-margin, r0+margin]);

%% 7. Animation: move the planet marker along the trajectory
fprintf('Animating orbit...\n');
step = max(1, floor(length(T) / 200));   % show ~200 frames
for i = 1:step:length(T)
    set(planet_marker, 'XData', x(i), 'YData', y(i));
    drawnow;
    pause(0.01);
end
fprintf('Animation finished.\n');

%% 8. ODE function (central force in polar coordinates)
function dstate = orbit_ode(~, state)
    % state = [theta; theta_dot; r; r_dot]
    theta_dot = state(2);
    r = state(3);
    r_dot = state(4);
    
    G = 6.67430e-11;
    M_sun = 1.989e30;
    
    % Equations:
    dtheta_dt = theta_dot;
    dr_dt = r_dot;
    dtheta_dot_dt = -2 * r_dot * theta_dot / r;
    dr_dot_dt = r * theta_dot^2 - G * M_sun / r^2;
    
    dstate = [dtheta_dt; dtheta_dot_dt; dr_dt; dr_dot_dt];
end