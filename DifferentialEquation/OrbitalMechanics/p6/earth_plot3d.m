clc;clear all;close all;
[T Y]=ode45(@fun,0:10:10^6,[0 150*10^9 0 0 0 0 0 0 30*10^4 0 0 0]);
for i=1:100:length(T)
    plot3(Y(i,1),Y(i,3),Y(i,5),'.b','markersize',5);
    hold on;
    axis([-150*10^9 150*10^9 -150*10^9 150*10^9 -150*10^9 150*10^9]);

    
    pause(0.01);
end
% p=figure();
% stars=imread('stars.jpg');
% set(p,'color','k','numbertitle','off');
% ha1=axes('position',[0 0 1 1]);
% imshow(stars);
% ha2=axes('position',[0 0 1 1]);
% [x y z]=sphere;
% [xs ys zs]=sphere;
% xs=5*xs;
% ys=5*ys;
% zs=5*zs;
% im2=imread('sun3.png');
% h2=surf(xs,ys,zs,'facecolor','y','edgecolor','none');
% hold on
% z=flipud(z);
% im=imread('earth.png');
% set(h2,'cdata',im2,'facecolor','texturemap','edgecolor','none');
% h=surf(x,y,z);
% axis off
% set(h,'cdata',im,'facecolor','texturemap','edgecolor','none');
% axis image
% rotate3d on
% axis([-150*10^9 150*10^9 -150*10^9 150*10^9 -150*10^9 150*10^9]);
% % i=0;
% % while 1==1
% % i=i+1;
% % view([i 0]);
% % pause(0.01);
% % end
% % theta=0:0.01:2*pi;
% % a=50*cos(theta);
% % b=50*sin(theta);
% % plot(a,b,'r');
% % plot(a/5,b/5,'b');
% % plot(a/2,b/2,'c');
% % camzoom(2)
% while 1==1
%     g=0;
% for i=1:length(T)
%     g=g+0.04;
%     x1=x*cos(-6)-z*sin(-6);
%     z1=x*sin(-6)+z*cos(-6);
%     x2=x1*cos(g)-y*sin(g);
%     y2=x1*sin(g)+y*cos(g);
%     set(h,'xdata',x2+Y(i,2),'ydata',y2+Y(i,4),'zdata',Y(i,6));
% %     light('Position',[0 0 0],'Style','infinite');
% % campos([25,0,0]);
% % camtarget([a(i),b(i),0]);
% % camroll(10)
% pause(0.05);   
% end
% end