function dx=navasan(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=(-2000/150)*x(1);
end