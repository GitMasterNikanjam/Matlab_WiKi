clc;clear variables;close all;
% #########################################################

n = input('please insert your number of parts ');
m = input('please insert your number of circles ');

while mod(n,2) ~= 0;
    disp('please insert a even number ');
    n = input('');
end

theta = linspace(0,2*pi,n+1);

hold on
axis([-(m+0.1) m+0.1 -(m+0.1) m+0.1]);
axis equal

cl = ['k' 'w'];

for ii = 1:n
    k = theta(ii):0.05:theta(ii+1);
    p = theta(ii+1):-0.05:theta(ii);
    for jj = 1:m
        fill([(jj-1)*cos(k) jj*cos(p)],[(jj-1)*sin(k)...
        jj*sin(p)],cl(rem(ii + 1,2)+1));
        pause(0.001)
    end
end



