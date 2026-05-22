% hal moadele difransieli : 
% xdot+x=sin(t)
clc;clear all;close all;
tf=linspace(0,5,25);
f=sin(tf);
[T,Y]=ode45(@(t,x) moadele5(t,x,tf,f),0:0.01:2,1);
plot(T,Y);

