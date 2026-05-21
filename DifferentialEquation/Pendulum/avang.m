function dx=avang(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=-9.81*cosd(x(1));
end