clc;close all;
op=odeset('abstol',10^(-1));
[T,Y]=ode45(@navasan_2degree,0:0.01:10,[pi/3 0 pi/6 0],op);
pen=plot([0 ,sin(Y(1,1)), sin(Y(1,1))+sin(Y(1,3))],[0 , -cos(Y(1,1)), -cos(Y(1,1))-cos(Y(1,3))],'-ok','markerfacecolor','k','markersize',5);
hold on
axis([-2.2 2.2 -2.2 2.2]);
axis square
t2=plot(sin(Y(1,1))+sin(Y(1,3)),-(cos(Y(1,1))+cos(Y(1,3))));
pictureframe(1)=getframe(gcf);
for ii=2:length(T)
   set(pen,'xdata',[0 sin(Y(ii,1)) sin(Y(ii,1))+sin(Y(ii,3))],'ydata',[0  -cos(Y(ii,1)) -cos(Y(ii,1))-cos(Y(ii,3))]);
set(t2,'xdata',sin(Y(1:ii,1))+sin(Y(1:ii,3)),'ydata',-(cos(Y(1:ii,1))+cos(Y(1:ii,3))) );
% pictureframe(ii)=getframe(gcf);
pause(0.001);


end

% movie2avi(pictureframe,'2d avang','fps',10,'compression','none','quality',100);