clc;clear all;close all;
[T,Y]=ode45(@navasan,0:0.02:10,[1.5 0]);
Y(:,1)=Y(:,1)./max(Y(:,1));
earth=fill([-0.15 0.15 0.15 -0.15],[0 0 0.1 0.1],'g');
theta=0:0.01:16*pi;
hold on
spring=plot(0.1.*sin(theta),linspace(0,-Y(1,1)-1,length(theta)),'k','linewidth',2);
mass=plot(0,-Y(1,1)-1,'ok','markerfacecolor','k','markersize',15);
axis([-1 1 -1.9 0.1]);
axis square
for ii=2:length(T)
    set(mass,'ydata',-Y(ii,1)-1);
    set(spring,'ydata',linspace(0,-Y(ii,1)-1,length(theta)));
    pause(0.01)

end


