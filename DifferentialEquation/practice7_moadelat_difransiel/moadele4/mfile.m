% moadele y(2dot)+y(dot)+y=sin(t)
clc;clear all;close all;
[T,Y]=ode45(@moadele4,0:0.01:10,[1 2]);
plot(T,Y);