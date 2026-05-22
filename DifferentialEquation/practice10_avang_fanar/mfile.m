clc;clear all;close all;
earth=fill([-0.2 0 0 2 2 -0.2],[0 0 2 2 2.2 2.2],'g');
axis equal 
axis([-0.3 2.2 -0.3 2.5]);
hold on;
[T,Y]=ode45(@navasan,0:0.05:60,[5 0]);
mille=plot([1 1],[2 0],'linewidth',5);
x=0:0.01:1;
y=0.1.*sin(60.*x);
spring=plot(x,y);
for ii=1:length(T)
    r=sqrt(4*(1-cosd(Y(ii,1))^2)+(1+2*sind(Y(ii,1)))^2);
    alpha=atand(2*(1-cosd(Y(ii,1)))/(1+2*sind(Y(ii,1))));
        x=linspace(0,r*cosd(alpha),length(y));
    set(mille,'xdata',[1 1+2*sind(Y(ii,1))],'ydata',[2 2*(1-cosd(Y(ii,1)))]);
    set(spring,'xdata',x*(1+2*sin(alpha)));
    set(spring,'xdata',x*cosd(alpha)-y*sind(alpha),'ydata',x*sind(alpha)+y*cosd(alpha));
pause(0.001);
end

