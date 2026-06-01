% Clear command window, remove all variables, close all figures
clc; clear all; close all;

% Prompt user for number of columns (m) and rows (n)
m = input('please insert your m number ');
n = input('please insert your n number ');

% Create equally spaced x-coordinates from 0 to 1 (m+1 points)
x = linspace(0, 1, m+1);
% Create equally spaced y-coordinates from 0 to 1 (n+1 points)
y = linspace(0, 1, n+1);

% Hold current plot so all squares are drawn on the same figure
hold on

% Loop over each column (1 to m)
for ii = 1:m
    % Loop over each row (1 to n)
    for jj = 1:n
        % Determine colour: black if (row+col) even, white otherwise
        if rem(ii+jj, 2) == 0
            cl = 'k';   % black
        else
            cl = 'w';   % white
        end
        % Draw filled square using x(ii), x(ii+1) and y(jj), y(jj+1)
        % Order: bottom-left, bottom-right, top-right, top-left, back to start
        fill([x(ii) x(ii+1) x(ii+1) x(ii) x(ii)], ...
             [y(jj) y(jj) y(jj+1) y(jj+1) y(jj)], cl);
    end
end