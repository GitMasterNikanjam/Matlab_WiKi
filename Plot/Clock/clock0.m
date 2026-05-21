clc;clear all;close all;
n=input('please insert your number ');
theta=linspace(0,-2*pi,n);
xe=cos(theta);
ye=sin(theta);
for ii=1:n
    plot([0,xe(ii)],[0,ye(ii)],'k','linewidth',3);
    hold on
    plot(xe(ii),ye(ii),'sk','markerfacecolor','k','markersize',10);
    plot(0,0,'ok','markersize',30,'markerfacecolor','k');
    hold off
    axis([-1.1 1.1 -1.1 1.1]);
    axis square
    pause(1)
end
