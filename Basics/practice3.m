clc;clear variables;close all;

n = input('please insert your number ');
hold on
axis([-0.1 1.1 -0.1 1.1]);
axis square;

for ii = 1:n+1
    plot([0,1-(ii-1)/n],[((ii-1)/n),0],'-o','color',rand(1,3)...
        ,'linewidth',2)
    plot([(ii-1)/n,1],[0,(ii-1)/n],'-o','color',[rand,rand,rand]...
        ,'linewidth',2)
    plot([0,1-(ii-1)/n],[1-(ii-1)/n,1],'-o','color',[rand,rand,rand]...
        ,'linewidth',2)
    plot([1,(ii-1)/n],[1-(ii-1)/n,1],'-o','color',[rand,rand,rand]...
        ,'linewidth',2)
            pause(0.1)
end