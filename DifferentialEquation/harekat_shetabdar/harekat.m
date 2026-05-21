function dx=harekat(t,x,t1,f1)
dx=[0 0]';
f1=interp1(t1,f1,t);
dx(1)=x(2);
dx(2)=f1;
end