function pendulum_spring_demo
%% PENDULUM_SPRING_DEMO
% Improved version of the pendulum-spring simulation.
% The ODE is exactly the same as your original (preserves your physics).
% Improvements:
%   - Proper use of radians/degrees (ODE uses degrees internally)
%   - Cleaner animation (no unnecessary recomputation inside loop)
%   - Removed 'clear all' (use 'clear variables' instead)
%   - Added axis labels, legend, grid
%   - Precomputed mass positions for smooth animation

    clc;
    clear variables;
    close all;

    %% Simulation parameters (same as yours)
    g = 9.81;
    m = 40;
    k = 2000;
    % No L_natural needed – the spring extension is computed directly in ODE

    %% Time span and initial condition (theta in degrees)
    t_span = [0, 60];
    theta0_deg = 5;    % initial angle in degrees
    omega0 = 0;
    initial_cond = [theta0_deg; omega0];

    %% Solve ODE (using your original function, but converted to degrees)
    % Note: The ODE function 'navasan' expects theta in DEGREES.
    [T, Y] = ode45(@navasan, t_span, initial_cond);
    theta_deg = Y(:,1);
    omega = Y(:,2);

    %% Precompute mass positions for animation
    % From your original code: x_mass = 1 + 2*sind(theta), y_mass = 2*(1-cosd(theta))
    x_mass = 1 + 2*sind(theta_deg);
    y_mass = 2*(1 - cosd(theta_deg));

    % Fixed wall point (where spring attaches)
    wall_x = 1;
    wall_y = 2;

    %% Set up figure
    figure('Name', 'Pendulum with Spring', 'NumberTitle', 'off');
    hold on;
    axis equal;
    axis([-0.5 3.5 -0.5 3]);
    grid on;
    xlabel('x (m)');
    ylabel('y (m)');
    title('Pendulum-Spring System (Original Dynamics)');

    % Draw ground/wall (green patch)
    fill([-0.2, 0, 0, 2, 2, -0.2], [0, 0, 2, 2, 2.2, 2.2], [0.6, 0.8, 0.6], 'EdgeColor', 'none');

    % Pendulum line (from pivot at (0,0) to mass)
    pendulum_line = plot([0, x_mass(1)], [0, y_mass(1)], 'k-', 'LineWidth', 3);

    % Spring line (from wall to mass)
    spring_line = plot([wall_x, x_mass(1)], [wall_y, y_mass(1)], 'r--', 'LineWidth', 2);

    % Mass marker
    mass_marker = plot(x_mass(1), y_mass(1), 'bo', 'MarkerSize', 12, 'MarkerFaceColor', 'b');

    % Mark the wall attachment point
    plot(wall_x, wall_y, 'ks', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

    legend('Wall', 'Pendulum', 'Spring', 'Mass', 'Attachment', 'Location', 'best');

    %% Animation loop
    fprintf('Animating...\n');
    for i = 1:length(T)
        set(pendulum_line, 'XData', [0, x_mass(i)], 'YData', [0, y_mass(i)]);
        set(spring_line,   'XData', [wall_x, x_mass(i)], 'YData', [wall_y, y_mass(i)]);
        set(mass_marker,   'XData', x_mass(i), 'YData', y_mass(i));
        drawnow;
        pause(0.01);
    end
    fprintf('Animation finished.\n');

    %% Nested ODE function (your original, unchanged)
    function dx = navasan(t, x)
        % x(1) = theta (degrees), x(2) = theta_dot
        theta = x(1);
        % Compute spring extension and torque using your exact formulas
        % (Note: sind, cosd, atand are used because theta is in degrees)
        r = sqrt(4*(1-cosd(theta)^2) + (1+2*sind(theta))^2);
        alpha = atand(2*(1-cosd(theta)) / (1+2*sind(theta)));
        dx = zeros(2,1);
        dx(1) = x(2);
        dx(2) = -9.81*sind(theta) - (k/m)*(r - 1)*cosd(theta - alpha);
    end

end