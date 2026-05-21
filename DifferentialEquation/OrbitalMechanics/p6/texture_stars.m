%% EF 105 Matlab Plotting Example
 % 3D surface with an image texture
 % Initialization
 clear all, close all, clc, format compact;
 % constants and initial values
 k = -.5;
 j = 0.6;
 % generate x,y,z values
 [x,y] = meshgrid([-3:.2:3],[-3:.2:3]);
 z = k.*(1-(cos(x.^2+y.^2))./(x.^2+y.^2+j));
 % draw the surface
 h = surf(x,y,z);
 % add the image to the surface
 img = imread('earth.png');
 set(h,'CData',img,'FaceColor','texturemap','edgecolor','none')
 axis off 
 axis image