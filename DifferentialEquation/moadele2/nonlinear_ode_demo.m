%% NONLINEAR_ODE_DEMO
% Solves the second-order nonlinear ODE:  y'' = - y * y'
% with initial conditions:  y(0) = 2,  y'(0) = 1.
%
% The equation is rewritten as a system of first-order ODEs:
%   let x1 = y' ,  x2 = y
%   then:
%       x1' = y'' = - x1 * x2
%       x2' = y'  = x1
%
% The system is solved using MATLAB's ode45.
% Two plots are generated:
%   1. Time history of y(t) and y'(t)
%   2. Phase plane (y' vs y)
%
% Author: MATLAB User
% Date:   Current date

%% Clean up
clc;
clear variables;      % Safer than 'clear all'
close all;

%% Time span and initial conditions
t_span = [0, 10];     % Integration interval
y0 = 2;               % Initial displacement y(0)
ydot0 = 1;            % Initial velocity y'(0)
initial_cond = [ydot0; y0];   % State = [y'; y]

%% Solve the ODE system using ode45
% The ODE function is defined locally (see below)
[T, X] = ode45(@ode_system, t_span, initial_cond);
% X(:,1) = y' , X(:,2) = y

%% Extract solution components
ydot = X(:,1);   % velocity
y = X(:,2);      % displacement

%% Plot 1: Time history
figure('Name', 'Time Response', 'NumberTitle', 'off');
subplot(2,1,1);
plot(T, y, 'b-', 'LineWidth', 1.5);
grid on;
ylabel('Displacement y(t)');
title('Nonlinear ODE: y'''' = - y * y''');
legend('y(t)', 'Location', 'best');

subplot(2,1,2);
plot(T, ydot, 'r-', 'LineWidth', 1.5);
grid on;
xlabel('Time t');
ylabel('Velocity y''(t)');
legend('y''(t)', 'Location', 'best');

%% Plot 2: Phase plane (velocity vs displacement)
figure('Name', 'Phase Plane', 'NumberTitle', 'off');
plot(y, ydot, 'k-', 'LineWidth', 1.5);
grid on;
xlabel('Displacement y');
ylabel('Velocity y''');
title('Phase Plane: y'' vs y');
axis equal;   % Maintain aspect ratio for better interpretation

%% Local function defining the ODE system
function dxdt = ode_system(~, x)
    % x(1) = y' , x(2) = y
    % dxdt(1) = y'' = - y' * y = - x(1) * x(2)
    % dxdt(2) = y'  = x(1)
    dxdt = zeros(2,1);
    dxdt(1) = -x(1) * x(2);   % y''
    dxdt(2) =  x(1);          % y'
end