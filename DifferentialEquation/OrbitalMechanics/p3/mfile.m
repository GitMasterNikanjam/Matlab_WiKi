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