clc;clear all;close all;
t1=0:0.01:10;
f1=t1;
[T,Y]=ode45(@(t,x) harekat(t,x,t1,f1),0:0.01:10,[0 0]);
plot(T,Y(:,1));