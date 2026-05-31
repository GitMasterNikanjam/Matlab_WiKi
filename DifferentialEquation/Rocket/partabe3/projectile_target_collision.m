%% PROJECTILE_TARGET_COLLISION (Fixed: no immediate collision)
clc;
clear variables;
close all;

%% Define target curve (change as desired)
target_func = @(x) sqrt(x) + sin(x/2);

%% Simulation parameters
g = 9.81;
initial_cond = [0; 0; 1; 40];   % [x; y; vx; vy]
tspan = [0, 10];

%% Set up ODE solver with event detection
opts = odeset('Events', @(t, x) collision_event(t, x, target_func));

% Solve ODE
[T, Y] = ode45(@(t, x) [x(3); x(4); 0; -g], tspan, initial_cond, opts);

%% Extract trajectory
x_traj = Y(:,1);
y_traj = Y(:,2);

%% Plot target curve up to impact point
x_target = linspace(0, x_traj(end), 500);
y_target = target_func(x_target);

figure('Name', 'Projectile vs Target Curve', 'NumberTitle', 'off');
plot(x_traj, y_traj, 'b-', 'LineWidth', 1.5); hold on;
plot(x_target, y_target, 'r--', 'LineWidth', 1.5);
plot(x_traj(end), y_traj(end), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
grid on;
xlabel('Horizontal distance (m)');
ylabel('Height (m)');
title(sprintf('Collision at x = %.2f m, y = %.2f m', x_traj(end), y_traj(end)));
legend('Projectile', 'Target curve', 'Collision point', 'Location', 'best');
axis equal;

fprintf('Collision detected at x = %.2f m, y = %.2f m, time = %.2f s\n', ...
        x_traj(end), y_traj(end), T(end));

%% Local event function (fixed)
function [value, isterminal, direction] = collision_event(~, x, target_func)
    y_target = target_func(x(1));
    value = x(2) - y_target;
    isterminal = 1;
    direction = -1;   % Only trigger when crossing from above (positive to negative)
end