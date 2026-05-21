clc;clear all;close all;
[T Y]=ode45(@fun,0:0.1:1000,[0 pi/40 (6400*10^3+2*10^5) 0]);
p=figure();
set(p,'color','k');
q=plot(0,0,'ok','markersize',30,'markerfacecolor','b');
set(q,'color','k');
hold on
grid off
axis off
for i=1:length(Y(:,1))
    x=Y(i,3)*cos(Y(i,1));
    y=Y(i,3)*sin(Y(i,1));
    plot(x,y,'ok','markersize',5,'markerfacecolor','g');
    axis([-7000*10^3 7000*10^3 -7000*10^3 7000*10^3]);
    pause(0.07); 
end