clc;clear variables;close all;
% #############################################

n = input('please insert your number ');

while mod(n,2)~=0
    disp('please insert a even number ');
    n=input('');
end

theta = linspace(0,2*pi,n+1);
hold on
axis([-1.1 1.1 -1.1 1.1]);
axis equal

for ii=1:n
    if rem(ii,2)==0
        cl='k';
    else
        cl='w';
    end
    fill([0 cos(theta(ii)) cos(theta(ii+1))],[0 sin(theta(ii))...
     sin(theta(ii+1))],cl);
end



