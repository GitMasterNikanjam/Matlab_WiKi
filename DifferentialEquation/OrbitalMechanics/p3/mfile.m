clc;clear all;close all;
[T Y]=ode45(@fun,0:0.01:1000,[0 5*6400*10^3 0 0 0 11^5 0 11^5]);
p=figure();
set(p,'color','k');
for i=1:100:length(Y(:,1))
    hold off
    plot(Y(i,1),Y(i,3),'ok','markersize',5,'markerfacecolor','b'); 
    hold on
    plot(Y(i,2),Y(i,4),'ok','markersize',5,'markerfacecolor','b'); 
    axis([0 7550*10^4 0 9550*10^4]);
    axis off
    pause(0.001);   
end

function dx=fun(t,x)
dx=[0 0 0 0 0 0 0 0]';
G=6.672*(10^(-7));
m=5.9742*10^24;
dx(1)=x(5);
dx(2)=x(6);
dx(3)=x(7);
dx(4)=x(8);
dx(5)=(G*m)/((x(1)-x(2))^2+(x(3)-x(4))^2)^(3/2)*(x(2)-x(1));
dx(6)=-dx(5);
dx(7)=(G*m)/((x(1)-x(2))^2+(x(3)-x(4))^2)^(3/2)*(x(4)-x(3));
dx(8)=-dx(7);
end