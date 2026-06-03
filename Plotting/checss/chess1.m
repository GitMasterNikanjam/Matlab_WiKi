clc;                    % Clear Command Window
clear all;              % Remove all variables from workspace
close all;              % Close all figure windows

m = input('please insert your m number ');   % Number of columns (horizontal squares)
n = input('please insert your n number ');   % Number of rows (vertical squares)

hold on                  % Keep current plot when adding new graphics
axis([0 m 0 n])          % Set axes limits: x from 0 to m, y from 0 to n
axis equal               % Equal scaling for x and y axes

% Loop over each column (ii = x‑coordinate of left edge)
for ii = 0:m-1
    % Loop over each row (jj = y‑coordinate of bottom edge)
    for jj = 0:n-1
        % Determine square colour: black if (ii+jj) even, white otherwise
        if rem(ii+jj, 2) == 0
            cl = 'k';      % black
        else
            cl = 'w';      % white
        end
        % Draw a filled square with vertices in order:
        % bottom‑left, bottom‑right, top‑right, top‑left, back to bottom‑left
        fill([ii ii+1 ii+1 ii ii], [jj jj jj+1 jj+1 jj], cl);
        pause(0.01);       % Short pause to animate the drawing
    end
end