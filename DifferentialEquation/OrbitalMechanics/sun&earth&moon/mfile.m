clc;clear all;close all;
[T Y]=ode45(@fun,0:1:100000,[150*10^9 150*10^9+30000*10^3 0 0 0 0 29.78*10^3 29.78*10^3+4.023*10^3]);
for i=1:400:length(T)
%     hold off
plot(Y(i,1),Y(i,3),'.b','markersize',30);
hold on
plot(Y(i,2),Y(i,4),'.k','markersize',6);
% axis([-150.1*10^9 150.1*10^9 -150.1*10^9 150.1*10^9]);
pause(0.01);
end