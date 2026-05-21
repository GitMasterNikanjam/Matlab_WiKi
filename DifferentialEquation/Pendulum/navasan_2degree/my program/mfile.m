clc;clear all;close all;
op=odeset('abstol',10^(-5));
[T Y]=ode45(@fun,0:0.01:20,[0 0 pi/2 0],op);
l1=1;
l2=1;
pen=plot([0 ,l1*sin(Y(1,1)), l1*sin(Y(1,1))+l2*sin(Y(1,3))],[0 , -l1*cos(Y(1,1)), -l1*cos(Y(1,1))-l2*cos(Y(1,3))],'-ok','markerfacecolor','k','markersize',5);
hold on
axis([-2.2 2.2 -2.2 2.2]);
axis square
t2=plot(sin(Y(1,1))+sin(Y(1,3)),-(cos(Y(1,1))+cos(Y(1,3))));
pictureframe(1)=getframe(gcf);
for ii=2:length(T)
   set(pen,'xdata',[0 sin(Y(ii,1)) sin(Y(ii,1))+sin(Y(ii,3))],'ydata',[0  -cos(Y(ii,1)) -cos(Y(ii,1))-cos(Y(ii,3))]);
set(t2,'xdata',sin(Y(1:ii,1))+sin(Y(1:ii,3)),'ydata',-(cos(Y(1:ii,1))+cos(Y(1:ii,3))) );
pause(0.001);
end
