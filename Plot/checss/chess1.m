clc;clear all;close all;
m=input('please insert your m number ');
n=input('please insert your n number ');
hold on
axis([0 m 0 n])
axis equal
for ii=0:m-1
    
    for jj=0:n-1
        if rem(ii+jj,2)==0
            cl='k';
        else 
            cl='w';
        end
        fill([ii ii+1 ii+1 ii ii],[jj jj jj+1 jj+1 jj],cl);
        pause(0.01);
    end
end