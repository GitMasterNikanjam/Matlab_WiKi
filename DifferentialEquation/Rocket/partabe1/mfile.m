% name project = shooting a particled mass in x-y face
% boundery condition :
% g=cte=9.81 , initial velocity = v0 , initial degree of rocket = theta ...
% initial place in (0,0)
% out put program :
% range , max height , theta for max range , plot trajectory in motion ...
% until the mass receive on the ground
% program solving in numeric
clc;clear all;close all;
v0=input('please insert your initial velocity : ');
theta=input('please insert your initial theta : ');
g=9.81;
range=2*v0^2*sind(theta)*cosd(theta)/9.81
time=range/(v0*cos(theta))
theta_for_max_range=45
max_height=-(1/2)*9.81*(time/2)^2+v0*sin(theta)*time/2
[T,Y]=ode45(@partabe,0:0.1:10,[0 v0*cosd(theta) 1 v0*sind(theta)]);
for ii=1:length(T)
plot(Y(ii,1),Y(ii,3),'ok','markerfacecolor','k','markersize',6);
axis([0 200 0 200]);
pause(0.1);
xlabel('x');
ylabel('y');
end


