clc;clear all;close all;
picture=imread('a.jpg');
while 1==1
    time=clock;
alphah=mod(time(4),12)*30+0.5*time(5);
alpham=6*time(5)+0.1*time(6);
plot(0,0);
        hold on
        image(picture,'xdata',[1 -1],'ydata',[1 -1]);
    plot([0 0.5*cosd(-alphah+90)],[0 0.5*sind(-alphah+90)],'linewidth',3,...
        'color','r');
    plot([0 0.7*cosd(-alpham+90)],[0 0.7*sind(-alpham+90)],'linewidth',2,...
        'color','g');
    plot([0 0.9*cosd(90-floor(time(6))*6)],[0 0.9*sind(90-floor(time(6))*6)]);
        hold off;
    axis([-1.1 1.1 -1.1 1.1]);
    axis square;axis off
    pause(0.01);
end