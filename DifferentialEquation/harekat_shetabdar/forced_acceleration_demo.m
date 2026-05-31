%% FORCED_ACCELERATION_DEMO
% Solves the second-order ODE:  x'' = t  (acceleration equals time)
% with initial conditions: x(0) = 0, x'(0) = 0.
% The equation is rewritten as a system of first-order ODEs:
%   x1' = x2
%   x2' = t
% where x1 = x, x2 = x'.
% The analytical solution is x(t) = t^3/6.

%% Clean up
clc;
clear variables;      % Safer than 'clear all'
close all;

%% Time span and initial conditions
t_span = [0, 10];     % integration interval
x0 = 0;               % initial displacement
v0 = 0;               % initial velocity
initial_cond = [x0; v0];

%% Solve ODE using ode45
% The ODE function is defined inline for clarity
[T, X] = ode45(@(t, x) [x(2); t], t_span, initial_cond);
% X(:,1) = x(t) , X(:,2) = x'(t)

%% Extract displacement
x = X(:,1);

%% Plot numerical solution
figure('Name', 'Forced Acceleration Response', 'NumberTitle', 'off');
plot(T, x, 'b-', 'LineWidth', 1.5);
grid on;
xlabel('Time t');
ylabel('Displacement x(t)');
title('Solution of x'''' = t,  x(0)=0, x''(0)=0');

%% Optional: overlay analytical solution for verification
t_analytical = linspace(0, 10, 200);
x_analytical = t_analytical.^3 / 6;
hold on;
plot(t_analytical, x_analytical, 'r--', 'LineWidth', 1.5);
legend('ode45 numerical', 'Analytical: t^3/6', 'Location', 'best');
hold off;

%% Display final value for curiosity
fprintf('At t = %.2f, numerical x = %.4f, analytical x = %.4f\n', ...
        T(end), x(end), T(end)^3/6);