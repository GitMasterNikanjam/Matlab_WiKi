clc;clear vriables;close all;
n = input('please insert your number ');

hold on;
axis([-0.1 1.1 -0.1 1.1]);
axis square;

for ii=1:n
        plot([ii/n,1],[0,ii/n],'-o','color',[rand,rand,rand]...
            ,'linewidth',1)
        plot([ii/n,1],[1,1-ii/n],'-o','color',[rand,rand,rand]...
             ,'linewidth',1)
        plot([1,1-ii/n],[ii/n,1],'-o','color',[rand,rand,rand]... 
             ,'linewidth',1)
        plot([0,ii/n],[ii/n,1],'-o','color',[rand,rand,rand]...
             ,'linewidth',1)
        pause(0.1)
end