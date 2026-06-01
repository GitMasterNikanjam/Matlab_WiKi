%% SATELLITE_ORBIT_DEMO
% Simulates a circular orbit of a satellite around Earth.
% User inputs the altitude above Earth's surface (in km).
% The script computes the required orbital velocity and animates the orbit.
% Earth is drawn as a blue circle, the satellite as a red dot.

clc;
clear variables;      % safer than 'clear all'
close all;

%% 1. Constants
G = 6.671e-11;        % gravitational constant (m^3/kg/s^2)
M = 5.972e24;         % Earth mass (kg)
R_earth = 6400e3;     % Earth radius (m) – 6400 km

%% 2. User input with validation
altitude_km = input('Please enter distance of satellite from Earth''s surface (km): ');
if ~isscalar(altitude_km) || ~isnumeric(altitude_km) || altitude_km < 0
    error('Altitude must be a non‑negative number.');
end

% Convert altitude to metres and compute orbital radius
r_orb = R_earth + altitude_km * 1000;   % metres

%% 3. Compute circular orbital velocity
v_orb = sqrt(G * M / r_orb);            % m/s

fprintf('\nSatellite altitude: %.2f km\n', altitude_km);
fprintf('Orbital radius:     %.2f km\n', r_orb / 1000);
fprintf('Orbital velocity:   %.2f m/s\n', v_orb);

%% 4. Initial conditions (satellite starts at (r, 0) with velocity (0, v_orb))
initial_cond = [r_orb; 0; 0; v_orb];   % [x; y; vx; vy]

%% 5. Simulation time
% One orbital period: T = 2*pi*r / v
period = 2 * pi * r_orb / v_orb;
t_end = 2 * period;                    % simulate for two orbits
t_span = [0, t_end];
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);

%% 6. Solve ODE
[T, Y] = ode45(@(t, x) orbit_ode(t, x, G, M), t_span, initial_cond, options);
% Y(:,1)=x, Y(:,2)=y, Y(:,3)=vx, Y(:,4)=vy

%% 7. Set up figure for animation
fig = figure('Name', 'Satellite Orbit', 'NumberTitle', 'off', ...
             'Color', 'k', 'MenuBar', 'none');
hold on;
axis equal;
axis off;
title('Satellite orbiting Earth', 'Color', 'w');

% Draw Earth as a filled blue circle
theta_circle = linspace(0, 2*pi, 200);
earth_x = R_earth * cos(theta_circle);
earth_y = R_earth * sin(theta_circle);
earth_patch = fill(earth_x, earth_y, 'b', 'EdgeColor', 'none');

% Satellite marker (red dot)
satellite = plot(Y(1,1), Y(1,2), 'r.', 'MarkerSize', 40);

% Optional: draw the orbit path (faint white line)
orbit_line = plot(Y(:,1), Y(:,2), 'w:', 'LineWidth', 0.5);

% Set initial axis limits (will be updated during animation)
margin = 0.1 * r_orb;   % 10% margin around the orbit
axis_lim = r_orb + margin;
axis([-axis_lim, axis_lim, -axis_lim, axis_lim]);

%% 8. Animation loop (update only the satellite position)
fprintf('Animating orbit...\n');
step = max(1, floor(length(T) / 500));   % show about 500 frames for speed
for i = 1:step:length(T)
    set(satellite, 'XData', Y(i,1), 'YData', Y(i,2));
    drawnow;
    pause(0.01);
end
fprintf('Animation finished.\n');

%% 9. Local ODE function (accepts G and M as parameters)
function dxdt = orbit_ode(~, x, G, M)
    % x = [x; y; vx; vy]
    r = sqrt(x(1)^2 + x(2)^2);
    accel = -G * M / r^3;        % common factor for acceleration components
    dxdt = [x(3); x(4); accel * x(1); accel * x(2)];
end