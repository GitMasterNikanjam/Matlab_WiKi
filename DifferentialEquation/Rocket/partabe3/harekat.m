function dx=harekat(t,x)
dx=[0 0 0 0]';
dx(1)=x(3);
dx(2)=x(4);
dx(3)=0;
dx(4)=-9.81;
end