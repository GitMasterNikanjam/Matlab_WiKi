%% COUPLED_OSCILLATORS_DEMO
% Solves a system of two coupled second-order ODEs, rewritten as 4 first-order ODEs:
%   Let x1 = position of mass 1,   x2 = position of mass 2
%       v1 = velocity of mass 1,   v2 = velocity of mass 2
%
% The equations (from the original code) are:
%   v1' = -v1 - v2 - 3*(x1 + x2)
%   v2' = -v2 - (x2 - x1)
%   x1' = v1
%   x2' = v2
%
% Initial conditions: x1(0)=10, v1(0)=0, x2(0)=10, v2(0)=0.
% The simulation runs from t=0 to t=10.
%
% The phase plane plot shows x1 vs v1 (or modify as needed).

%% Clean up
clc;
clear variables;      % Safer than 'clear all'
close all;

%% Time span and initial conditions
t_span = [0, 10];                 % simulation interval
initial_cond = [10; 0; 10; 0];    % [x1; v1; x2; v2]

%% Solve ODE system using ode45
[T, Y] = ode45(@ode_system, t_span, initial_cond);
% Y(:,1) = x1 , Y(:,2) = v1 , Y(:,3) = x2 , Y(:,4) = v2

%% Extract states for clarity
x1 = Y(:,1);
v1 = Y(:,2);
x2 = Y(:,3);
v2 = Y(:,4);

%% Plot 1: Phase plane of the first mass (x1 vs v1)
figure('Name', 'Phase Plane (Mass 1)', 'NumberTitle', 'off');
plot(x1, v1, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Displacement x_1');
ylabel('Velocity v_1');
title('Phase Plane of Mass 1');
axis equal;

%% Optional Plot 2: Time history of all states
figure('Name', 'Time Response', 'NumberTitle', 'off');
subplot(2,2,1);
plot(T, x1, 'b-', 'LineWidth', 1.5);
grid on; title('x_1(t)'); xlabel('t'); ylabel('x_1');

subplot(2,2,2);
plot(T, v1, 'r-', 'LineWidth', 1.5);
grid on; title('v_1(t)'); xlabel('t'); ylabel('v_1');

subplot(2,2,3);
plot(T, x2, 'g-', 'LineWidth', 1.5);
grid on; title('x_2(t)'); xlabel('t'); ylabel('x_2');

subplot(2,2,4);
plot(T, v2, 'm-', 'LineWidth', 1.5);
grid on; title('v_2(t)'); xlabel('t'); ylabel('v_2');

%% Local function defining the ODE system
function dxdt = ode_system(~, x)
    % x(1) = x1 , x(2) = v1 , x(3) = x2 , x(4) = v2
    dxdt = zeros(4,1);
    dxdt(1) = x(2);                                          % dx1/dt = v1
    dxdt(2) = -x(2) - x(4) - 3*(x(1) + x(3));               % dv1/dt
    dxdt(3) = x(4);                                          % dx2/dt = v2
    dxdt(4) = -x(4) - (x(3) - x(1));                         % dv2/dt
end