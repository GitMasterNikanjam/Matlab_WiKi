% moadele y(2dot)=sin(y)
% bl: y=1 ydot=2
clc;clear all;close all;
[T,Y]=ode45(@moadele2,0:0.01:10,[1 2]);
plot(T,Y);
