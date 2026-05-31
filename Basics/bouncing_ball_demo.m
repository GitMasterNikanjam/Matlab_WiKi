%% BOUNCING_BALL_DEMO
% Simulates and plots the height of a bouncing ball over time.
% The ball is launched upward from ground level with initial velocity v0.
% At each bounce, the vertical velocity is reduced by a restitution factor
% (0.8 here) – the ball never reaches its original height.
%
% The motion between bounces follows the parabolic equation:
%     y(t) = -0.5 * g * t^2 + v * t
% where g = 9.81 m/s², v is the velocity just after the previous bounce.
% The time of flight for each bounce is t_flight = 2 * v / g.

clc;                 % Clear Command Window
clear variables;     % Clear variables (safer than 'clear all')
close all;           % Close all figure windows

%% Simulation Parameters
g = 9.81;            % Gravity (m/s²)
v0 = 10;             % Initial upward velocity (m/s)
restitution = 0.8;   % Coefficient of restitution (speed after / speed before)
numBounces = 10;     % Number of bounces to simulate

% Preallocate cell arrays for storing trajectory data (optional)
% We'll just plot as we go.

%% Set Up the Figure
figure('Name', 'Bouncing Ball Simulation', 'NumberTitle', 'off');
hold on;
grid on;
xlabel('Time (seconds)');
ylabel('Height (meters)');
title(sprintf('Bouncing Ball: v0 = %.1f m/s, restitution = %.2f', v0, restitution));

% Initialise time offset
tStart = 0;
v = v0;              % current velocity just after bounce (or initial launch)

%% Simulate Each Bounce
for bounce = 1:numBounces
    % Compute time of flight for this parabolic arc
    % The ball starts at y=0, goes up, and returns to y=0 when t = 2*v/g.
    tFlight = 2 * v / g;
    
    % Create a fine time vector for this bounce (from 0 to tFlight)
    tSegment = linspace(0, tFlight, 200);
    
    % Compute height during this segment: y = -0.5*g*t^2 + v*t
    y = -0.5 * g * tSegment.^2 + v * tSegment;
    
    % Shift time by the cumulative time from previous bounces
    tPlot = tStart + tSegment;
    
    % Plot the trajectory for this bounce with a distinct colour
    % Colours cycle automatically if we don't specify 'Color'
    plot(tPlot, y, 'LineWidth', 1.5);
    
    % Update for next bounce: reduce velocity, shift start time
    v = restitution * v;      % velocity after bounce (reduced)
    tStart = tStart + tFlight;
end

%% Final Adjustments
hold off;
legend(arrayfun(@(b) sprintf('Bounce %d', b), 1:numBounces, 'UniformOutput', false));
% Optionally, mark the bounces with vertical lines
for b = 1:numBounces-1
    % Cumulative flight times (end of each bounce)
    tEnd = sum(2 * v0 * restitution.^(0:b-1) / g);
    xline(tEnd, '--k', sprintf('Bounce %d', b));
end

fprintf('Simulation finished. Final time: %.2f seconds\n', tStart);