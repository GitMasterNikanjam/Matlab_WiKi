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

function dx=fun(t,x)
dx=[0 0 0 0]';
G=6.672*(10^(-7));
m0=5.9742*10^24;
dx(1)=x(2);
dx(3)=x(4);
dx(2)=(-2*x(4)*x(2))/x(3);
dx(4)=x(3)*(x(2)^2)-(G*m0)/(x(3)^2);
end