%% ODE_SIN_FORCED
% Solves the first-order linear ODE:  dx/dt + x = sin(t),  with x(0)=1.
% Equivalent to: dx/dt = -x + sin(t).
%
% The solution is computed using MATLAB's ode45 solver and plotted.
%
% Author: MATLAB User
% Date:   Current date

%% Clean up (use clear variables instead of clear all for safety)
clc;
clear variables;
close all;

%% Simulation parameters
t_span = [0, 2];        % time interval [start, end]
x0 = 1;                 % initial condition: x(0) = 1

%% Solve the ODE
% The forcing term sin(t) is used directly inside the ODE function.
[T, X] = ode45(@(t, x) -x + sin(t), t_span, x0);

%% Plot the result
figure('Name', 'Solution of dx/dt + x = sin(t)', 'NumberTitle', 'off');
plot(T, X, 'b-', 'LineWidth', 2);
grid on;
xlabel('Time t');
ylabel('State x(t)');
title('Solution of \frac{dx}{dt} + x = \sin(t),  x(0)=1');
legend('x(t)', 'Location', 'best');

%% Optional: compare with analytical solution
% The analytical solution is:  x(t) = e^{-t} + 0.5*(sin(t) - cos(t))
% Uncomment below to overlay exact solution.
% t_exact = linspace(0, 2, 200);
% x_exact = exp(-t_exact) + 0.5*(sin(t_exact) - cos(t_exact));
% hold on;
% plot(t_exact, x_exact, 'r--', 'LineWidth', 1.5);
% legend('ode45', 'Exact solution', 'Location', 'best');