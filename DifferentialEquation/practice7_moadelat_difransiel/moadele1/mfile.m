% moadele y(3dot)+ ydot=0
% bl :  y=1 ydot=2 y(2dot)=3
clc;clear all;close all;
[T,Y]=ode45(@moadele1,0:0.01:10,[1 2 3]);
plot(T,Y);

