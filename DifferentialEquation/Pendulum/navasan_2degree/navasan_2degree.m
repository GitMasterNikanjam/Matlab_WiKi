function dx=navasan_2degree(t,x)
dx=[0 0 0 0]';
dx(1)=x(2);
dx(3)=x(4);
ans=[2 cos(x(1)-x(3));cos(x(1)-x(3)) 1]\[-19.62*sin(x(1))-x(4)^2*sin(x(1)-x(3));-9.81*sin(x(3))+x(2)^2*sin(x(1)-x(3))];
dx(2)=ans(1);
dx(4)=ans(2);
end
