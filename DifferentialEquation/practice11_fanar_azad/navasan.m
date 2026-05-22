function dx=navasan(t,x)
dx=[0 0 0 0]';
dx(1)=x(2);
dx(2)=-(2000/40)*(sqrt(x(1)^2+x(3)^2)-1)*x(1)/sqrt(x(1)^2+x(3)^2);
dx(3)=x(4);
dx(4)=-(2000/40)*(sqrt(x(1)^2+x(3)^2)-1)*x(3)/sqrt(x(1)^2+x(3)^2)-9.81;
end