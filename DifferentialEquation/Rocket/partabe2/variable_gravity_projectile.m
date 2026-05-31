%% VARIABLE_GRAVITY_PROJECTILE
% Simulates a projectile launched from (0,0) with initial speed v0 and angle theta.
% Gravity varies with height: g(y) = G * M_earth / (R_earth + y)^2.
% The ODE system is solved numerically until the projectile hits the ground (y=0).
%
% Outputs:
%   - Range (horizontal distance when y=0)
%   - Maximum height
%   - Animated trajectory

clc;
clear variables;      % Safer than 'clear all'
close all;

%% 1. Physical constants (realistic values)
G = 6.67430e-11;      % gravitational constant (m^3/kg/s^2)
M_earth = 5.9722e24;  % Earth mass (kg)
R_earth = 6371000;    % Earth mean radius (m)

%% 2. User input with validation
v0 = input('Please enter initial velocity (m/s): ');
if ~isscalar(v0) || ~isnumeric(v0) || v0 <= 0
    error('Velocity must be a positive number.');
end

theta_deg = input('Please enter launch angle (degrees, 0-90): ');
if ~isscalar(theta_deg) || ~isnumeric(theta_deg) || theta_deg < 0 || theta_deg > 90
    error('Launch angle must be between 0 and 90 degrees.');
end

%% 3. Initial conditions
theta_rad = deg2rad(theta_deg);
vx0 = v0 * cos(theta_rad);
vy0 = v0 * sin(theta_rad);
initial_cond = [0; vx0; 0; vy0];   % [x; vx; y; vy]

%% 4. Numerical solution using ode45
% ODE function: dx/dt = vx, dvx/dt = 0, dy/dt = vy, dvy/dt = -g(y)
% g(y) = G*M/(R+y)^2
ode_fun = @(t, x) [x(2); 
                    0; 
                    x(4); 
                    -G * M_earth / (R_earth + x(3))^2];

% Time span: integrate until ground impact (detected via event)
options = odeset('Events', @ground_event, 'Refine', 5);
t_span = [0, 1e6];   % large upper bound, event will stop early

[T, Y, te, ye] = ode45(ode_fun, t_span, initial_cond, options);
% Y(:,1)=x, Y(:,2)=vx, Y(:,3)=y, Y(:,4)=vy

%% 5. Extract results
x = Y(:,1);
y = Y(:,3);
max_height = max(y);
range = x(end);

fprintf('\n========== Results ==========\n');
fprintf('Initial velocity  : %.2f m/s\n', v0);
fprintf('Launch angle      : %.2f°\n', theta_deg);
fprintf('Flight time       : %.2f s\n', T(end));
fprintf('Range             : %.2f m (%.2f km)\n', range, range/1000);
fprintf('Maximum height    : %.2f m (%.2f km)\n', max_height, max_height/1000);
fprintf('=============================\n');

%% 6. Animation
figure('Name', 'Projectile with Variable Gravity', 'NumberTitle', 'off');
hold on;
axis equal;
grid on;
xlabel('Horizontal distance (km)');
ylabel('Height (km)');
title(sprintf('v0 = %.1f m/s, θ = %.1f° (variable gravity)', v0, theta_deg));

% Convert to km for plotting
x_km = x / 1000;
y_km = y / 1000;

% Initial plot limits (adjust if range is huge)
xlim([0, max(x_km) * 1.05]);
ylim([0, max(y_km) * 1.05]);

% Trajectory line and current marker
traj_line = plot(NaN, NaN, 'b-', 'LineWidth', 1.5);
ball = plot(x_km(1), y_km(1), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Animation loop
for i = 2:length(T)
    set(traj_line, 'XData', x_km(1:i), 'YData', y_km(1:i));
    set(ball, 'XData', x_km(i), 'YData', y_km(i));
    drawnow;
    pause(0.02);
end

% Mark landing point
plot(x_km(end), y_km(end), 'ks', 'MarkerSize', 10, 'LineWidth', 1.5);
legend('Trajectory', 'Projectile', 'Landing point', 'Location', 'best');
hold off;

%% Local event function: stop when y becomes 0 (ground)
function [value, isterminal, direction] = ground_event(~, x)
    value = x(3);          % y position
    isterminal = 1;        % stop integration
    direction = -1;        % only when y is decreasing (hits ground from above)
end