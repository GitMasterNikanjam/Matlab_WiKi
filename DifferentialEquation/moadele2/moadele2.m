function dx=moadele2(t,x)
dx=[0 0]';
dx(2)=x(1);
dx(1)=-x(1)*x(2);
end