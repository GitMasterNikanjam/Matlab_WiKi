clc;clear all;close all; %#ok

% ###################################################
% Global Variables

v=10;           % Initial velocity
hold on;        % hold sequenses plots
tStart = 0;     % Start the time for each touching. 

for i=1:10
    tRoot = fzero(@(t)fun(t,v), [0.2,1000]);
    tEquation = 0:0.01:tRoot;
    y = (-0.5 * 9.81 * (tEquation.^2)) + (v .* tEquation);
    tPlot = tEquation + tStart;
    plot(tPlot,y);
    v = 0.8 * v;
    tStart = tStart + tRoot;
end
    