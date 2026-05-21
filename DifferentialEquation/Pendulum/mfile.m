clc;clear all;close all;
[T,y]=ode45(@avang,0:0.1:100,[91 0]);
hold on
earth=fill([-0.15 0.15 0.15 -0.15],[0 0 0.1 0.1],'g');
pen=plot([0 cosd(y(1,1))],[0 sind(y(1,1))],'k');
mass=plot(cosd(y(1,1)),sind(y(1,1)),'ok','markerfacecolor','k','markersize',8);
pin=plot(0,0,'ok','markerfacecolor','k','markersize',4);
axis([-1.1 1.1 -1.1 1.1]);
axis square
for ii=2:length(T)
    set(mass,'xdata',cosd(y(ii,1)),'ydata',sind(y(ii,1)));
    set(pen,'xdata',[0 cosd(y(ii,1))],'ydata',[0 sind(y(ii,1))]);
    pause(0.01);
    
end


