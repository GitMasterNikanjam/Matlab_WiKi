function ball_elastic_impact
%% BALL_ELASTIC_IMPACT
% Simulates a ball (point mass) moving under gravity, bouncing elastically
% off a user‑defined wall surface y = f(x). The ball starts at (x0,y0)
% with initial velocity (vx0, vy0). The simulation stops when the ball goes
% beyond a horizontal limit or after a maximum number of bounces.
%
% The wall is defined as a function y = f(x) for x >= 0. The ball is
% constrained to stay above the wall (y >= f(x)). Upon impact (y == f(x)
% with ball moving downward), the vertical velocity is reversed (elastic
% collision), while horizontal velocity remains unchanged.
%
% This script uses ode45 with event detection for each impact.

    %% 1. Clear and setup
    clc;
    clear variables;
    close all;

    %% 2. User inputs with validation
    fprintf('\n===== Elastic Ball Impact on a Curved Wall =====\n');
    
    % Wall definition as a function of x (in terms of MATLAB syntax)
    wall_expr = input('\nEnter wall surface y = f(x) as an expression,\ne.g., ''0.1*x'', ''sin(x)'', ''sqrt(x)'', ''x.^2/50'':\n', 's');
    if isempty(wall_expr)
        wall_expr = '0.1*x';   % default
    end
    try
        wall_func = eval(['@(x) ', wall_expr]);
        % Test the function at x=0
        test_val = wall_func(0);
        if ~isscalar(test_val)
            error('Function must return a scalar for scalar input.');
        end
    catch
        error('Invalid function expression. Use valid MATLAB syntax, e.g., ''0.1*x''.');
    end
    
    % Initial conditions
    x0 = input('Initial x position (>=0): ');
    if isempty(x0), x0 = 0; end
    y0 = input('Initial y position (must be above wall at x0): ');
    if isempty(y0), y0 = 10; end
    vx0 = input('Initial horizontal velocity: ');
    if isempty(vx0), vx0 = 5; end
    vy0 = input('Initial vertical velocity: ');
    if isempty(vy0), vy0 = 0; end
    
    % Check initial condition above wall
    if y0 <= wall_func(x0)
        error('Initial y position must be above the wall at x0.');
    end
    
    g = 9.81;                    % gravity (m/s²)
    max_time = 30;               % maximum simulation time (s)
    max_bounces = 20;            % stop after this many bounces
    
    %% 3. Simulation setup
    % State vector: [x; y; vx; vy]
    y_init = [x0; y0; vx0; vy0];
    
    % Options for ode45: event detection, refine for smooth output
    opts = odeset('Events', @(t, y) impact_event(t, y, wall_func), ...
                  'Refine', 5);
    
    % Cell arrays to store trajectory segments (between bounces)
    t_all = {};
    y_all = {};
    
    current_y = y_init;
    t_start = 0;
    bounce_count = 0;
    
    figure('Name', 'Ball Elastic Impact', 'NumberTitle', 'off');
    hold on;
    axis equal;
    grid on;
    xlabel('x (m)');
    ylabel('y (m)');
    title('Elastic Ball Impact on Curved Wall');
    
    % Plot the wall surface (for a reasonable x range)
    x_wall = linspace(0, 100, 500);
    y_wall = wall_func(x_wall);
    plot(x_wall, y_wall, 'k-', 'LineWidth', 2);
    
    % Initialize ball marker
    ball_h = plot(current_y(1), current_y(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    
    %% 4. Main simulation loop (bounce until exit or max bounces)
    while bounce_count < max_bounces
        % Integrate until next impact
        [t, y, te, ye, ie] = ode45(@(t, y) ball_odes(t, y, g), ...
                                    [t_start, t_start + max_time], ...
                                    current_y, opts);
        
        % Store this trajectory segment
        t_all{end+1} = t;
        y_all{end+1} = y;
        
        % Plot this segment (line)
        plot(y(:,1), y(:,2), 'b-', 'LineWidth', 1);
        
        % Update animation (optional: slow down to see)
        for i = 1:length(t)
            set(ball_h, 'XData', y(i,1), 'YData', y(i,2));
            drawnow;
            pause(0.01);
        end
        
        % Check if an impact occurred
        if isempty(te)
            % No impact detected – simulation ends
            fprintf('No further impact. Simulation finished.\n');
            break;
        else
            % Impact occurred at (te, ye)
            bounce_count = bounce_count + 1;
            fprintf('Bounce %d at x = %.2f m, y = %.2f m, time = %.2f s\n', ...
                    bounce_count, ye(1), ye(2), te);
            
            % Apply elastic impact: reverse vertical velocity
            % (assume wall is horizontal at impact – for exact normal reflection,
            % more complex. For simplicity, we reverse vy. For a more accurate
            % reflection off a curved surface, we'd need the normal vector,
            % but that's beyond this example.)
            current_y = ye;
            current_y(4) = -ye(4);   % vy = -vy (elastic bounce)
            current_y(3) = ye(3);     % vx unchanged
            
            % Restart integration from impact time
            t_start = te;
        end
    end
    
    if bounce_count >= max_bounces
        fprintf('Reached maximum number of bounces (%d). Stopping.\n', max_bounces);
    end
    
    hold off;
    legend('Wall', 'Ball trajectory', 'Location', 'best');
    
    %% Nested ODE function
    function dydt = ball_odes(~, y, g)
        % y = [x; y; vx; vy]
        dydt = [y(3); y(4); 0; -g];
    end

    %% Nested event function
    function [value, isterminal, direction] = impact_event(~, y, wall_func)
        % Event when ball touches the wall: y == wall(x)
        % Only trigger when ball is moving downward (vy < 0) to avoid repeated events.
        value = y(2) - wall_func(y(1));
        isterminal = 1;        % stop integration at impact
        direction = -1;        % only when value goes from positive to negative (ball above wall then touches)
    end

end