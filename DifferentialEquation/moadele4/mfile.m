clc;clear all;close all;
[T Y]=ode45(@moadele4,0:0.01:10,[10 0 10 0]);
plot(Y(:,1),Y(:,2));