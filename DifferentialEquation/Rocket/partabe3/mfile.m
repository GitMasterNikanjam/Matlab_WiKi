clc;clear all;close all;
t=0:0.01:100;
y=sqrt(t)+sin(t./2);
op=odeset('event',@barkhord);
[T,Y]=ode45(@harekat,0:0.01:10,[0 0 1 40],op);
 plot(Y(:,1),Y(:,2));
hold on;
plot(t,y);