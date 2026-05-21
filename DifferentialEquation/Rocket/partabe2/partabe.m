function dx=partabe(t,x)
dx=[0 0 0 0]';
dx(1)=x(2);
dx(2)=0;
dx(3)=x(4);
dx(4)=-g;
end