clc;clear all;close all;
n=input('adade khod ra vared konid ');
x=linspace(0,1,n);
hold on
axis([-0.1 1.2 -.1 1.2]);
axis square
for ii=1:n
    plot([0,x(end-ii+1)],[x(ii),0],'-s','color',...
        [rand,rand,rand],'linewidth',1,'markerfacecolor','g');
    pause(0.1)
end