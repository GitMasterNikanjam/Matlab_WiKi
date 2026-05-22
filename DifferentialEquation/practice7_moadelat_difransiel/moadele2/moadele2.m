function dx=moadele2(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=sin(x(1));
end