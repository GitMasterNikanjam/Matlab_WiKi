clc;clear all;close all;
R=5; 
quality=100; 
[x,y,z]=sphere(quality); 
x=R*x; 
y=R*y; 
z=R*z; 
z(find(z<=0))=NaN; 
i=double(imread('stars.jpg'));
h=mesh(x,y,z);
set(h,'cdata',i,'facecolor','texturemap','edgecolor','none');
axis off
axis image;