clc;clear all;close all;
[x y]=meshgrid(-1:0.1:1,-2:0.1:2);
z=sqrt(x.^2+y.^2);
surf(x,y,z);
colormap('lines');