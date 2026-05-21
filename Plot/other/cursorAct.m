clc;clear all;close all;
win=figure();
set(win,'units','pixels');
ax=axes('parent',win);
ball=plot([cos(linspace(0,2*pi,100))],[sin(linspace(0,2*pi,100))],'b');
set(ball,'parent',ax);
axis([0,1000,0,1000]);
while 1
    vec=get(0,'pointerlocation');
    set(ball,'xdata',100*[cos(linspace(0,2*pi,100))]+vec(1),'ydata',100*[sin(linspace(0,2*pi,100))]+vec(2));
    pause(0.01);
end
