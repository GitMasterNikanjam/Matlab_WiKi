clc;clear all;close all;
[T,Y]=ode45(@navasan,0:0.01:20,[1 0 0 0]);
spring=plot([0 2],[0 0],'linewidth',3);
hold on;
mass=plot(1,0,'ok','markersize',10,'markerfacecolor','k');
axis equal
axis([-3 3 -3 3]);
for ii=1:length(T)
  set(spring,'xdata',[0 Y(ii,1)],'ydata',[0 Y(ii,3)]);
  set(mass,'xdata',Y(ii,1),'ydata',Y(ii,3));
    pause(0.01);
end