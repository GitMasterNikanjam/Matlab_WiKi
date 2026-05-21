clc;clear all;close all;
time=clock;
alphah=mod(time(4),12)*30+0.5*time(5);
alpham=6*time(5)+0.1*time(6);
picture=imread('a.jpg');
for ii=linspace(floor(time(6))*6,floor(time(6))*6+360,61)
    
    image(picture,'XData',[-1 1],'YData',[-1 1]);
    hold on
    plot([0 0.5*cosd(-alphah+90)],[0 0.5*sind(-alphah+90)],'linewidth',3,...
        'color','r');
    plot([0 0.7*cosd(-alpham+90)],[0 0.7*sind(-alpham+90)],'linewidth',2,...
        'color','g');
    plot([0 0.9*cosd(-ii+90)],[0 0.9*sind(-ii+90)]);
    axis([-1.1 1.1 -1.1 1.1]);
    axis square
    pause(1);
    hold off;
    time=clock;
alphah=mod(time(4),12)*30+0.5*time(5);
alpham=6*time(5)+0.1*time(6);
end