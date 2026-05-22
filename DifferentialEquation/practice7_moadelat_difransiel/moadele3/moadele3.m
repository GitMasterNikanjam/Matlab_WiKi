function dx=moadele3(t,x);
dx=[0 0 0 0 0 0]';
dx(1)=x(2);
dx(2)=x(3);
dx(3)=-(x(2)+x(6));
dx(4)=x(5);
dx(5)=x(2)-x(4);
end
