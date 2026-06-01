% =========================================================================
% TWO-BODY PROBLEM SIMULATION (NEWTONIAN GRAVITY)
% =========================================================================
% This script simulates the motion of two equal-mass bodies under mutual
% gravitational attraction. The equations of motion are integrated using
% MATLAB's ODE45 solver. The results are visualized as a 3D animation.
%
% PHYSICAL PARAMETERS:
%   G  = 6.672e-7  [cm^3/(g·s^2)] – gravitational constant (CGS units)
%   m1 = m2 = 5.9742e24 [g]       – mass of each body (Earth mass)
%
% INITIAL CONDITIONS (CGS units: centimeters and seconds):
%   Body 1: position  (0, 0, 0) cm, velocity (0, 0, 0) cm/s
%   Body 2: position  (5*6400e3, 0, 0) cm = 3.2e7 cm,
%           velocity  (12^5, 12^5, 12^5) cm/s ≈ (2.48832e5, ...) cm/s
%   NOTE: 12^5 = 248832 cm/s – this velocity is very high (escape velocity
%         from Earth's surface is ~1.12e6 cm/s). The chosen value may lead
%         to unbound orbits or numerical issues.
%
% NUMERICAL SETUP:
%   Time span: t = 0 to 10000 seconds, with output every 0.01 s.
%   ODE45 relative tolerance: default (1e-3).
%   State vector Y = [x1, x2, y1, y2, z1, z2, vx1, vx2, vy1, vy2, vz1, vz2]
%
% PLOTTING:
%   Every 1000th time step (i.e., every 10 seconds) the positions of the
%   two bodies are plotted in 3D. Body 1 is red, Body 2 is blue.
%   The axes are equal and the view is fixed to the range [0, 5*6400e4]
%   (0 to 3.2e8 cm) in each direction.
%
% KNOWN ISSUES / CAVEATS:
%   1. The gravitational force uses r^(3/2) in the denominator instead of
%      the correct r^3 (Newton's law requires r^2 in denominator, leading
%      to a factor of 1/r^3 after vector multiplication). This is a
%      physical error – the current code does not simulate correct gravity.
%   2. The initial velocity of Body 2 is extremely high and directed
%      diagonally; the system likely has non-zero total momentum,
%      causing the center of mass to drift.
%   3. The masses are equal, but the force on Body 2 is scaled by -(m1/m2)
%      to conserve momentum – this is correct only if the center of mass
%      is initially stationary. In this code, the total momentum is not
%      zero, so the center of mass will accelerate.
% =========================================================================

clc; clear all; close all;

% Integrate the equations of motion
[T, Y] = ode45(@fun, 0:0.01:10000, [0 5*6400*10^3 0 0 0 0 0 12^5 0 12^5 0 12^5]);

% Animate the results: plot every 1000th point (every 10 seconds)
for i = 1:1000:length(T)
    % Plot Body 1 (red) and Body 2 (blue) as dots
    plot3(Y(i,1), Y(i,3), Y(i,5), '.r', 'markersize', 5);
    hold on;
    plot3(Y(i,2), Y(i,4), Y(i,6), '.b', 'markersize', 5);
    
    % Set up the axes
    axis equal;
    grid on;
    axis([0 5*6400*10^4 0 5*6400*10^4 0 5*6400*10^4]);
    
    pause(0.01);   % Slow down animation for visualization
end

% -------------------------------------------------------------------------
% FUNCTION DEFINING THE ODE SYSTEM (TWO-BODY GRAVITY)
% -------------------------------------------------------------------------
function dx = fun(t, x)
    % Initialize derivative vector (12 components, all zero)
    dx = zeros(12,1);
    
    % Gravitational constant and masses (CGS units)
    G = 6.672e-7;          % cm^3/(g·s^2)
    m1 = 5.9742e24;        % g (Earth mass)
    m2 = 5.9742e24;        % g (equal mass)
    
    % Relative distance between the two bodies (vector components)
    dx_pos = x(2) - x(1);
    dy_pos = x(4) - x(3);
    dz_pos = x(6) - x(5);
    r = sqrt(dx_pos^2 + dy_pos^2 + dz_pos^2);   % Euclidean distance
    
    % NOTE: The following force expressions use r^(3/2) instead of r^3.
    %       Correct Newtonian gravity would be: (G*m2)/r^3 * (dx_pos)
    %       The current exponent is a physical mistake.
    force_factor = G * m2 / r^(3/2);   % Incorrect factor
    
    % Velocities
    dx(1) = x(7);   % vx1
    dx(2) = x(8);   % vx2
    dx(3) = x(9);   % vy1
    dx(4) = x(10);  % vy2
    dx(5) = x(11);  % vz1
    dx(6) = x(12);  % vz2
    
    % Accelerations (Newton's second law)
    dx(7)  =  force_factor * (x(2) - x(1));   % ax1
    dx(8)  = -(m1/m2) * dx(7);                % ax2 (conserves momentum)
    dx(9)  =  force_factor * (x(4) - x(3));   % ay1
    dx(10) = -(m1/m2) * dx(9);                % ay2
    dx(11) =  force_factor * (x(6) - x(5));   % az1
    dx(12) = -(m1/m2) * dx(11);               % az2
end