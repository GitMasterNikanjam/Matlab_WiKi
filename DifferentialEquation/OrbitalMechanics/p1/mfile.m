clc;clear all;close all;
[T Y]=ode45(@fun,0:10^7:1000000000000,[0 4*(10^(-6)) 150*10^9 0]);
for i=1:100:length(Y(:,1))
    x=Y(i,3)*cos(Y(i,1));
    y=Y(i,3)*sin(Y(i,1));
    plot(x,y,'ok','markersize',5);
    axis([-10^19 10^19 -10^19 10^19]);
    pause(0.001); 
end