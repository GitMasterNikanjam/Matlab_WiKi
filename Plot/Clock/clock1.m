clc;clear all;close all;
theta=linspace(0,2*pi,30);
x=cos(theta);
y=sin(theta);
hold on
axis([-1.2 1.2 -1.2 1.2])
axis square
for ii=1:length(theta)
    plot([0,x(ii)],[0,y(ii)]);
    tic;
    pause(0.1);
    toc
end