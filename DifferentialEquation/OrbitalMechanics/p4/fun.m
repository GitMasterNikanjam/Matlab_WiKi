function dx=fun(t,x)
dx=[0 0]';
k=0.1;
m=1;
g=9.81;
theta=atan(x(4)/x(3));
dx(1)=x(3);
dx(2)=x(4);
dx(3)=(-k*(x(3)^2+x(4)^2))*cos(theta)/m;
dx(4)=-g-(k*(x(3)^2+x(4)^2))*sin(theta)/m;
end