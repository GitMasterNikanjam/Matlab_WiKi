clc;clear all;close all;
[T Y]=ode45(@fun,0:0.01:10000,[0 5*6400*10^3 0 0 0 0 0 12^5 0 12^5 0 12^5]);
for i=1:1000:length(T)
   plot3(Y(i,1),Y(i,3),Y(i,5),'.r','markersize',5);
hold on
plot3(Y(i,2),Y(i,4),Y(i,6),'.b','markersize',5);
axis equal
grid on
axis([0 5*6400*10^4 0 5*6400*10^4 0 5*6400*10^4]);
    pause(0.01);
end
