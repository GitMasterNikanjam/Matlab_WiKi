%% PROJECTILE_MOTION_DEMO
% Simulates the trajectory of a projectile launched from (0,0) with initial
% speed v0 (m/s) and launch angle theta (degrees). Assumes constant gravity
% (g = 9.81 m/s²) and no air resistance.
%
% Outputs:
%   - Range (horizontal distance when y=0)
%   - Maximum height
%   - Theoretical angle for maximum range (45°)
%   - Animated trajectory until ground impact

clc;
clear variables;      % Safer than 'clear all'
close all;

%% 1. Get user input with validation
v0 = input('Please enter initial velocity (m/s): ');
if ~isscalar(v0) || ~isnumeric(v0) || v0 <= 0
    error('Velocity must be a positive number.');
end

theta_deg = input('Please enter launch angle (degrees, 0-90): ');
if ~isscalar(theta_deg) || ~isnumeric(theta_deg) || theta_deg < 0 || theta_deg > 90
    error('Launch angle must be between 0 and 90 degrees.');
end

g = 9.81;             % gravity (m/s²)

%% 2. Analytical calculations
theta_rad = deg2rad(theta_deg);
vx0 = v0 * cos(theta_rad);
vy0 = v0 * sin(theta_rad);

% Flight time (for flat ground)
t_flight = 2 * vy0 / g;
% Range (horizontal distance)
range = vx0 * t_flight;
% Maximum height
max_height = (vy0^2) / (2 * g);
% Angle for maximum range (theoretical)
theta_max_range_deg = 45;

%% 3. Display results
fprintf('\n========== Projectile Motion Results ==========\n');
fprintf('Initial velocity : %.2f m/s\n', v0);
fprintf('Launch angle     : %.2f°\n', theta_deg);
fprintf('Flight time      : %.2f s\n', t_flight);
fprintf('Range            : %.2f m\n', range);
fprintf('Maximum height   : %.2f m\n', max_height);
fprintf('Theoretical θ_max: 45° (gives maximum range)\n');
fprintf('===============================================\n');

%% 4. Numerical solution (ODE) for animation
% State vector: [x; vx; y; vy]
initial_cond = [0; vx0; 0; vy0];
t_span = [0, t_flight];   % integrate exactly until flight time

[T, Y] = ode45(@(t, x) [x(2); 0; x(4); -g], t_span, initial_cond);
% Y(:,1) = x(t), Y(:,2) = vx(t), Y(:,3) = y(t), Y(:,4) = vy(t)

%% 5. Animation
figure('Name', 'Projectile Trajectory', 'NumberTitle', 'off');
hold on;
axis equal;
grid on;
xlabel('Horizontal distance (m)');
ylabel('Height (m)');
title(sprintf('Projectile: v0 = %.1f m/s, θ = %.1f°', v0, theta_deg));
xlim([0, max(Y(:,1)) + 5]);
ylim([0, max(Y(:,3)) + 5]);

% Draw trajectory line (updated each frame)
traj_line = plot(NaN, NaN, 'b-', 'LineWidth', 1.5);
% Current position marker
ball = plot(Y(1,1), Y(1,3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Animation loop
for i = 2:length(T)
    % Update trajectory (path up to current time)
    set(traj_line, 'XData', Y(1:i, 1), 'YData', Y(1:i, 3));
    % Update ball position
    set(ball, 'XData', Y(i, 1), 'YData', Y(i, 3));
    drawnow;
    pause(0.02);   % adjust animation speed
end

% Mark landing point
plot(Y(end,1), Y(end,3), 'ks', 'MarkerSize', 10, 'LineWidth', 1.5);
legend('Trajectory', 'Projectile', 'Landing point', 'Location', 'best');
hold off;

%% Local function for ODE (kept for clarity, though inline anonymous is used)
% function dxdt = projectile_ode(~, x)
%     dxdt = [x(2); 0; x(4); -9.81];
% end