clc;clear all;close all;
m=input('please insert your m number ');
n=input('please insert your n number ');
x=linspace(0,1,m+1);
y=linspace(0,1,n+1);
hold on
for ii=1:m
    for jj=1:n
        if rem(ii+jj,2)==0
            cl='k';
        else 
            cl='w';
        end
        fill([x(ii) x(ii+1) x(ii+1) x(ii) x(ii)],[y(jj) y(jj) y(jj+1)...
            y(jj+1) y(jj)],cl);
    end
end