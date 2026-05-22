function dx=moadele3(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=-3*x(2)-x(1);
end