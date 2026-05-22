% moadele y1(3dot)+y2(2dot)+y1(dot)=0 , y2(3dot)+y2(dot)-y1(dot)=0
clc;clear all;close all;
[T,Y]=ode45(@moadele3,0:0.01:10,[1 2 3 1 2 3]);
plot(T,Y);