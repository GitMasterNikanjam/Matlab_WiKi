function saat5
% SAAT5 - An analog clock with moving hands (hour, minute, second).
%   Creates a figure window with a traditional clock face, then starts three
%   timers to update the hour, minute, and second hands at appropriate intervals.
%   The function runs until the figure window is closed.

% Create the main figure window with custom settings
window = figure('name','saate man');
set(window, 'numbertitle','off', 'color','w', 'resize','off', 'menubar','none');
% Assign a custom close request function to clean up timers when the window is closed
set(window, 'closerequestfcn', @window_exit);

% Define a high-resolution angle vector for drawing circles
theta = 0:0.01:2*pi;

% Draw the outer thick black ring (clock bezel)
plot(9*cos(theta), 9*sin(theta), 'linewidth',8, 'color','k');
hold on;   % Keep subsequent drawings on the same axes

% Set up the axes: no ticks, square aspect, limits from -10 to 10
axis off;
axis([-10 10 -10 10]);
axis square;

% Draw two inner decorative rings (radii 8.1 and 8.5)
plot(8.1*cos(theta), 8.1*sin(theta), 'color','k');
plot(8.5*cos(theta), 8.5*sin(theta), 'color','k');

% Draw the minute ticks (60 small lines between radius 8.1 and 8.5)
theta = linspace(0, 2*pi, 61);              % 60 intervals -> 61 points
plot([8.1*cos(theta); 8.5*cos(theta)], ...
     [8.1*sin(theta); 8.5*sin(theta)], 'k');

% Draw the hour ticks (12 thick lines between radius 7.7 and 8.5)
theta = linspace(0, 2*pi, 13);              % 12 intervals -> 13 points
plot([7.7*cos(theta); 8.5*cos(theta)], ...
     [7.7*sin(theta); 8.5*sin(theta)], 'k', 'linewidth', 5);

% Add a decorative text (brand) at the center
text(0, 4, '\it nike', 'fontsize',10, 'horizontalalignment','center');

% Place the numbers 1 to 12 around the clock face
a = 1:12;
theta = pi/3:-pi/6:-3*pi/2;                 % Angles for numbers 1..12 (clockwise)
text(6.5*cos(theta), 6.5*sin(theta), num2str(a'), ...
     'horizontalalignment','center', 'verticalalignment','middle', 'fontsize',22);

% -------------------------------------------------------------------------
% Define the shapes of the three clock hands (all pointing upward initially)
% -------------------------------------------------------------------------
% Hour hand (green): polygon vertices (x,y)
xh = [-0.2 0.2 0.2 0 -0.2 -0.2];
yh = [-1  -1   3   4   3   -1];
% Minute hand (blue)
xm = [-0.2 0.2 0.2 0 -0.2 -0.2];
ym = [-2  -2   5.5 7   5.5 -2];
% Second hand (black)
xs = [-0.1 0.1 0.1 0 -0.1 -0.1];
ys = [-2  -2   6   7   6   -2];

% Create the filled polygon objects for each hand
m = fill(xm, ym, 'b');   % minute hand
s = fill(xs, ys, 'k');   % second hand
h = fill(xh, yh, 'g');   % hour hand

% Get the current time (as a 6-element vector: [year month day hour minute second])
time = clock;
ts = time(6);   % seconds
tm = time(5);   % minutes
th = mod(time(4), 12);   % hours (0-11)

% Set the initial rotation of the hour hand.
% Rotation angle = -(hours * 30° + minutes * 0.5°) in radians.
% Formula uses rotation matrix: x' = x*cosθ - y*sinθ, y' = x*sinθ + y*cosθ
set(h, 'xdata', xh*cos(-th*pi/6 - tm*pi/360) - yh*sin(-th*pi/6 - tm*pi/360), ...
       'ydata', xh*sin(-th*pi/6 - tm*pi/360) + yh*cos(-th*pi/6 - tm*pi/360));

% Set the initial rotation of the second hand.
% Angle = -seconds * 6° (pi/30 rad)
set(s, 'xdata', xs*cos(-ts*pi/30) - ys*sin(-ts*pi/30), ...
       'ydata', xs*sin(-ts*pi/30) + ys*cos(-ts*pi/30));

% Set the initial rotation of the minute hand.
% Angle = -(minutes * 6° + seconds * 0.1°)  -> smooth motion
set(m, 'xdata', xm*cos(-tm*pi/30 - ts*pi/1800) - ym*sin(-tm*pi/30 - ts*pi/1800), ...
       'ydata', xm*sin(-tm*pi/30 - ts*pi/1800) + ym*cos(-tm*pi/30 - ts*pi/1800));

% Draw the red center cap (small circle at the pivot)
theta = 0:0.01:2*pi;
fill(0.6*cos(theta), 0.6*sin(theta), 'r');

% -------------------------------------------------------------------------
% Create three timers to update the hands at different intervals
% -------------------------------------------------------------------------
% Timer 'b' (minute hand) updates every 2 seconds (calls @minute)
b = timer('timerfcn', @minute, 'period', 2, 'executionmode', 'fixedrate');
% Timer 'a' (second hand) updates every 1 second (calls @secend)
a = timer('timerfcn', @secend, 'period', 1, 'executionmode', 'fixedrate');
% Timer 'c' (hour hand) updates every 60 seconds (calls @hour)
c = timer('timerfcn', @hour, 'period', 60, 'executionmode', 'fixedrate');

% Start all three timers
start(a);
start(b);
start(c);

% -------------------------------------------------------------------------
% Nested callback functions for each timer
% -------------------------------------------------------------------------
    function minute(varargin)
        % Update the minute hand position (called every 2 seconds)
        time1 = clock;
        tm = time1(5);   % current minute
        % Rotate the minute hand using the current minute and the global
        % second value 'ts' (which is frozen from the initial time).
        % NOTE: This is a bug – 'ts' never updates inside this callback.
        set(m, 'xdata', xm*cos(-tm*pi/30 - ts*pi/1800) - ym*sin(-tm*pi/30 - ts*pi/1800), ...
               'ydata', xm*sin(-tm*pi/30 - ts*pi/1800) + ym*cos(-tm*pi/30 - ts*pi/1800));
    end

    function secend(varargin)
        % Update the second hand position (called every 1 second)
        time2 = clock;
        ts = time2(6);   % update seconds (including fractional part)
        set(s, 'xdata', xs*cos(-ts*pi/30) - ys*sin(-ts*pi/30), ...
               'ydata', xs*sin(-ts*pi/30) + ys*cos(-ts*pi/30));
        % Pause to synchronize with the exact second (fractional part)
        pause(time2(6) - floor(time2(6)));
    end

    function hour(varargin)
        % Update the hour hand position (called every 60 seconds)
        time3 = clock;
        th = time3(4);   % current hour (24-hour format)
        % Rotate the hour hand using the current hour and the global
        % minute 'tm' (which is frozen from the initial time).
        % NOTE: 'tm' never updates inside this callback – another bug.
        set(h, 'xdata', xh*cos(-th*pi/6 - tm*pi/360) - yh*sin(-th*pi/6 - tm*pi/360), ...
               'ydata', xh*sin(-th*pi/6 - tm*pi/360) + yh*cos(-th*pi/6 - tm*pi/360));
    end

    function window_exit(varargin)
        % Custom close function: stop and delete all timers, then close the figure
        closereq;        % execute the default close request (destroys the figure)
        stop(a);
        stop(b);
        stop(c);
        delete(a);
        delete(b);
        delete(c);
    end

end   % end of function saat5