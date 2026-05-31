%% PROJECTILE_ANIMATION
% Simulates the trajectory of a projectile under constant gravity.
% Equations of motion:
%   x'' = 0
%   y'' = -g
% with initial conditions: x(0)=5, y(0)=0, vx(0)=10, vy(0)=50.
%
% The ODE is solved numerically using ode45.
% An animated plot shows the projectile's path and current position.

clc;
clear variables;      % Safer than 'clear all'
close all;

%% Simulation parameters
g = 9.81;             % gravity (m/s^2)
initial_cond = [5; 0; 10; 50];   % [x0; y0; vx0; vy0]
t_span = [0, 10];     % time interval (seconds)

%% Solve ODE using ode45
% ODE function defined inline for clarity
[T, Y] = ode45(@(t, x) [x(3); x(4); 0; -g], t_span, initial_cond);
% Y(:,1) = x(t), Y(:,2) = y(t), Y(:,3) = vx(t), Y(:,4) = vy(t)

%% Find time when projectile hits the ground (y=0)
% Only keep trajectory until first ground impact (if any)
ground_idx = find(Y(:,2) < 0, 1, 'first');
if ~isempty(ground_idx)
    T = T(1:ground_idx);
    Y = Y(1:ground_idx, :);
end

%% Set up the figure for animation
figure('Name', 'Projectile Motion', 'NumberTitle', 'off');
hold on;
axis equal;
grid on;
xlabel('Horizontal distance x (m)');
ylabel('Height y (m)');
title('Projectile Trajectory Animation');
xlim([0, max(Y(:,1)) + 5]);
ylim([0, max(Y(:,2)) + 5]);

% Pre-plot the trajectory line (empty initially)
traj_handle = plot(NaN, NaN, 'b-', 'LineWidth', 1.5);
% Marker for current position
ball_handle = plot(Y(1,1), Y(1,2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');

%% Animate the trajectory
for i = 2:length(T)
    % Update trajectory line: show path up to current time
    set(traj_handle, 'XData', Y(1:i, 1), 'YData', Y(1:i, 2));
    % Update ball position
    set(ball_handle, 'XData', Y(i, 1), 'YData', Y(i, 2));
    
    drawnow;
    pause(0.02);   % adjustable animation speed
end

%% Optional: Display final information
fprintf('Flight time: %.2f s\n', T(end));
fprintf('Range: %.2f m\n', Y(end,1));
fprintf('Maximum height: %.2f m\n', max(Y(:,2)));