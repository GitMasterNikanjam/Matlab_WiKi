function dx=moadele4(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=-x(2)-x(4)-3*(x(1)+x(3));
dx(3)=x(4);
dx(4)=-x(4)-(x(3)-x(1));
end