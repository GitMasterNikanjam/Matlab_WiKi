clc;clear all;close all;
[T Y]=ode45(@moadele3,0:0.01:10,[1 2]);
plot(T,Y);
