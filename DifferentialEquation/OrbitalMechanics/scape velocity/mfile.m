clc;clear all;close all;
r=64*10^5;
G=6.671*10^(-11);
m=5.972*10^(24);
v_scape=sqrt(2*G*m/r);
[T Y]=ode45(@fun,0:100:1000000,[r 0 0 v_scape]);
theta=0:0.01:2*pi;
p=figure();
set(p,'menubar','none','color','k');
for i=1:10:length(T)
    hold off
    fill(r*cos(theta),r*sin(theta),'b');
hold on
plot(Y(i,1),Y(i,2),'.r','markersize',5);
axis equal;
axis off
pause(0.001);
end

function dx=fun(t,x)
dx=[0 0 0 0]';
G=6.671*10^(-11);
m=5.972*10^(24);
r=sqrt(x(1)^2+x(2)^2);
dx(1)=x(3);
dx(2)=x(4);
dx(3)=(G*m/(r^3))*(-x(1));
dx(4)=(G*m/(r^3))*(-x(2));
end

