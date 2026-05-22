function dx=moadele1(t,x)
dx=[0 0 0]';
dx(1)=x(2);
dx(2)=x(3);
dx(3)=-x(2);
end
