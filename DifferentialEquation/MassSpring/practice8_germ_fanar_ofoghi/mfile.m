clc;clear all;close all;
window=figure('name','spring_mass');
set(window,'numbertitle','off','color','w','menubar','none','resize','off');
fill([-0.2 2 2 0 0 -0.2 -0.2],[-0.1 -0.1 0 0 0.4 0.4 -0.1],'g');
axis equal;
axis([-0.2 2.2 -.1 1]);
[T,Y]=ode45(@navasan,0:0.01:30,[0.6 0]);
hold on;
axis off
x4=0:0.01:1;
spring=plot(x4,0.05.*sin(80.*x4)+0.2);
mass=fill([0.7 1.3 1.3 0.7],[0.1 0.1 0.3 0.3],'k');
theta=0:0.01:pi/2;
t=0:0.01:2*pi;
x1=[0 0.05 0.05*cos(theta) 0];
y1=[0 0 0.05*sin(theta) 0.05];
x2=[0 -0.05 0.05*cos(theta+pi) 0];
y2=[0 0 0.05*sin(theta+pi) -0.05];
x3=1+0.05*cos(t);
y3=0.05+0.05*sin(t);
wheel1=fill(x1,y1,'k');
wheel2=fill(x2,y2,'k');
wheel3=plot(x3,y3);
for ii=1:length(T)
    set(mass,'xdata',[0.7 1.3 1.3 0.7]+Y(ii,1))
    set(wheel1,'xdata',x1*cos(-Y(ii,1)/0.05)-y1*sin(-Y(ii,1)/0.05)+1+Y(ii,1),'ydata',...
        x1*sin(-Y(ii,1)/0.05)+y1*cos(-Y(ii,1)/0.05)+0.05);
    set(wheel2,'xdata',x2*cos(-Y(ii,1)/0.05)-y2*sin(-Y(ii,1)/0.05)+1+Y(ii,1),'ydata',...
        x2*sin(-Y(ii,1)/0.05)+y2*cos(-Y(ii,1)/0.05)+0.05);
    set(wheel3,'xdata',1+0.05*cos(t)+Y(ii,1));
    set(spring,'xdata',x4*(0.7+Y(ii,1)));
  

    pause(0.01);
end
