%% LINEAR_ODE_DEMO
% Solves the second-order linear ODE:  y'' + 3 y' + y = 0
% with initial conditions: y(0) = 2, y'(0) = 1.
%
% The equation is rewritten as a system of first-order ODEs:
%   let x1 = y, x2 = y'
%   then:
%       x1' = x2
%       x2' = -3*x2 - x1
%
% Solved using MATLAB's ode45.
% Plots: time history of y(t) and y'(t).

%% Clean up
clc;
clear variables;      % safer than 'clear all'
close all;

%% Time span and initial conditions
t_span = [0, 10];     % integration interval
y0 = 2;               % initial displacement y(0)
yDot0 = 1;            % initial velocity y'(0)
initial_cond = [y0; yDot0];   % state = [y; y']

%% Solve ODE system
[T, X] = ode45(@ode_system, t_span, initial_cond);
% X(:,1) = y , X(:,2) = y'

%% Extract results
y = X(:,1);
yDot = X(:,2);

%% Plot results
figure('Name', 'Linear ODE Solution', 'NumberTitle', 'off');
subplot(2,1,1);
plot(T, y, 'b-', 'LineWidth', 1.5);
grid on;
ylabel('Displacement y(t)');
title('y'''' + 3 y'' + y = 0');
legend('y(t)', 'Location', 'best');

subplot(2,1,2);
plot(T, yDot, 'r-', 'LineWidth', 1.5);
grid on;
xlabel('Time t');
ylabel('Velocity y''(t)');
legend('y''(t)', 'Location', 'best');

%% Optional: add analytical solution comparison (uncomment to use)
% The characteristic equation: r^2 + 3r + 1 = 0 -> r = (-3 ± sqrt(5))/2
% r1 = (-3 + sqrt(5))/2 ≈ -0.381966, r2 = (-3 - sqrt(5))/2 ≈ -2.61803
% y(t) = A*exp(r1*t) + B*exp(r2*t). Solve for A,B using y(0)=2, y'(0)=1.
% A = (y'(0) - r2*y(0))/(r1 - r2), B = y(0) - A.
% Uncomment below to overlay exact solution.
% r1 = (-3 + sqrt(5))/2;
% r2 = (-3 - sqrt(5))/2;
% A = (yDot0 - r2*y0) / (r1 - r2);
% B = y0 - A;
% t_exact = linspace(0, 10, 200);
% y_exact = A*exp(r1*t_exact) + B*exp(r2*t_exact);
% figure;
% plot(t_exact, y_exact, 'g--', 'LineWidth', 1.5);
% hold on;
% plot(T, y, 'b-', 'LineWidth', 1);
% grid on;
% xlabel('Time t'); ylabel('y(t)');
% legend('Analytical', 'ode45');

%% Local function defining the ODE system
function dxdt = ode_system(~, x)
    % x(1) = y , x(2) = y'
    dxdt = zeros(2,1);
    dxdt(1) = x(2);                 % y' = x2
    dxdt(2) = -3*x(2) - x(1);      % y'' = -3y' - y
end