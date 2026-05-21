clc;clear all;close all;
a=inputdlg({'longitudinal geometric :','latitude geometric :','xdot :','ydot :','zdot :'},'input',1,{'0','0','0','0','0'});
phi=str2double(a{1});
theta=str2double(a{2});
xdot=str2double(a{3});
ydot=str2double(a{4});
zdot=str2double(a{5});
r=64*10^5;
% p=figure();
% stars=imread('stars.jpg');
% set(p,'color','k','numbertitle','off');
% ha1=axes('position',[0 0 1 1]);
% imshow(stars);
% ha2=axes('position',[0 0 1 1]);
% axis 
% hold on;
% [x_earth y_earth z_earth]=sphere;
% z_earth=flipud(z_earth);
% x_earth=r*x_earth;
% y_earth=r*y_earth;
% z_earth=r*z_earth;
% im_earth=imread('earth.png');
% h_earth=surf(x_earth,y_earth,z_earth);
% set(h_earth,'cdata',im_earth,'facecolor','texturemap','edgecolor','none');
% axis off
% axis equal
[T Y]=ode45(@fun,0:1:4000,[r*cos(theta)*cos(phi) r*cos(theta)*sin(phi) r*sin(theta) xdot ydot zdot]);
for i=1:10:length(T)
    hold on
    ppp=plot3(Y(i,1),Y(i,2),Y(i,3),'.r');
axis([-2*r 2*r -2*r 2*r -2*r 2*r]); 
pause(0.01)
end


