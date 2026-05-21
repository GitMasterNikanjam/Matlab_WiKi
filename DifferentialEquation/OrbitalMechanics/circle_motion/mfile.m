clc;clear all;close all;
r=input('please insert distance body from surface of earth (km) :');
r=6400*10^3+r*1000;
G=6.671*10^(-11);
M=5.972*10^(24);
v=sqrt(G*M/r);
[T Y]=ode45(@fun,0:10:20000,[r 0 0 v]);
theta=0:0.01:2*pi;
p=figure();
set(p,'menubar','none','color','k');
R=6400*1000;
for i=1:10:length(T)
    hold off
    fill(R*cos(theta),R*sin(theta),'b');
hold on
plot(Y(i,1),Y(i,2),'.r','markersize',50);
axis equal;
axis off
axis([-(Y(1,1)+400) Y(1,1)+400 -(Y(1,1)+400) (Y(1,1)+400)]);
pause(0.01);
end
