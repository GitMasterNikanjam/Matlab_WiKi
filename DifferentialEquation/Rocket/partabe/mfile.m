clc;clear all;close all;
[T,Y]=ode45(@partabe,0:0.01:10,[5 0 10 50]);
for ii=1:length(T)
    
plot(Y(ii,1),Y(ii,2),'ok','markerfacecolor','k');
hold on
plot(Y(1:ii,1),Y(1:ii,2));
axis([0 100 0 140])
xlabel('x');
ylabel('y');
hold off
pause(0.01);
end
