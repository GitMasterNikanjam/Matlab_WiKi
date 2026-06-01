clc;clear all;close all;
[T Y]=ode45(@fun,0:0.01:6,[0 0 25*sqrt(2) 25*sqrt(2)]);
h1=axes('position',[0.05 0.05 0.9 0.9]);
im=imread('sky.jpg');
imshow(im);
h2=axes('position',[0.05 0.05 0.9 0.9]);
% xg=[0 max(Y(:,1)) max(Y(:,1)) 0];
% yg=[0 0 -5 -5];
xb=[0 1 1.2 1 0];
yb=[0 0 0.05 0.1 0.1]; 
xf1=[0 0.2 0.1 0];
yf1=[0.1 0.1 0.2 0.2];
yf2=-yf1+0.1;
xf3=[0 0.2 0.2 0];
yf3=[0.040 0.040 0.060 0.060];
xf=[xf1 xf1 xf3];
yf=[yf1 yf2 yf3];
% fill(xg,yg,'g');
hold on;
p1=fill(xb,yb,'b');
p2=fill(xf1,yf1,'r',xf1,yf2,'r',xf3,yf3,'r');
set(gcf,'color','k');
axis equal
axis([0 Y(end,1) -1 max(Y(:,2))+5]);
axis off
for i=1:length(Y(:,1))
t=atan(Y(i,4)/Y(i,3));
plot(Y(i,1),Y(i,2),'.k','markersize',4.5);
set(p1,'xdata',(xb*cos(t)-yb*sin(t))+Y(i,1),'ydata',(xb*sin(t)+yb*cos(t))+Y(i,2));
set(p2,'xdata',(xf*cos(t)-yf*sin(t))+Y(i,1),'ydata',(xf*sin(t)+yf*cos(t))+Y(i,2));
pause(0.05);
end

function dx=fun(t,x)
dx=[0 0]';
k=0.1;
m=1;
g=9.81;
theta=atan(x(4)/x(3));
dx(1)=x(3);
dx(2)=x(4);
dx(3)=(-k*(x(3)^2+x(4)^2))*cos(theta)/m;
dx(4)=-g-(k*(x(3)^2+x(4)^2))*sin(theta)/m;
end