% name project = shooting a particled mass in x-y face
% boundery condition :
% g=G*M_Earth/R^2 , initial velocity = v0 , initial degree of rocket = theta ...
% initial place in (0,0)
% out put program :
% range , max height , theta for max range , plot trajectory in motion ...
% until the mass receive on the ground
% program solving in numeric
clc;clear all;close all;
v0=input('please insert your initial velocity : ');
theta=input('please insert your initial theta : ');
G=6.67428*10^(-11);
M_Earth=89;
R-Earth=67
g=G*M_Earth/(R_Earth+y)
[T,Y]=ode45(@partabe,0:0.01:10,[0 v0*cosd(theta) 0 v0*sind(theta)]);
for ii=1:length(T)
plot(Y(ii,1),Y(ii,3),'ok','markerfacecolor','k','markersize',6);
axis([0 200 0 60]);
pause(0.01);
xlabel('x');
ylabel('y');
end


