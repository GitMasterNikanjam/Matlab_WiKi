% soghoot azad
clc;clear all;close all;
[T,Y]=ode45(@soghoot,0:0.01:2,[40 -5]);
plot(T,Y);