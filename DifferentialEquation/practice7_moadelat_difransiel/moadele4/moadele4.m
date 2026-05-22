function dx=moadele4(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=sin(t)-x(1)-x(2);
end