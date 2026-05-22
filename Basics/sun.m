clc;clear all;close all;
n=input('please insert your number ');
alpha=input('please insert your alpha ');
theta=linspace(0,2*pi,n);
x0=cos(theta);
y0=sin(theta);
xe=cos(theta+alpha);
ye=sin(theta+alpha);
hold on;
axis([-1.1 1.1 -1.1 1.1]);
axis square
for ii=1:n
    plot([x0(ii),xe(ii)],[y0(ii),ye(ii)],'color',rand(1,3));
    pause(0.1)
end
