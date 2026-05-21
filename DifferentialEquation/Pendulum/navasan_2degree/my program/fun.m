function dx=fun(t,x)
dx=zeros(1,4)';
m1=1;
m2=1;
l1=1;
l2=1;
g=9.81;
f2=-m2*(cos(x(3))*cos(x(1))+sin(x(1))*sin(x(3)))*g*cos(x(1))*m1/(m2*cos(x(1)-x(3))*sin(x(1))*sin(x(3))-m1-m2*sin(x(3))^2+m2*cos(x(1)-x(3))*cos(x(3))*cos(x(1))-m2*cos(x(3))^2);
ax=-g*cos(x(1))*(-sin(x(1))*m1-sin(x(1))*m2*cos(x(3))^2+m2*cos(x(1))*cos(x(3))*sin(x(3)))/(m2*cos(x(1)-x(3))*sin(x(1))*sin(x(3))-m1-m2*sin(x(3))^2+m2*cos(x(1)-x(3))*cos(x(3))*cos(x(1))-m2*cos(x(3))^2);
ay=-g*(-m2*cos(x(1))*cos(x(3))*sin(x(1))*sin(x(3))+cos(x(1))^2*m1+cos(x(1))^2*m2*sin(x(3))^2+m2*cos(x(1)-x(3))*sin(x(1))*sin(x(3))-m1-m2*sin(x(3))^2+m2*cos(x(1)-x(3))*cos(x(3))*cos(x(1))-m2*cos(x(3))^2)/(m2*cos(x(1)-x(3))*sin(x(1))*sin(x(3))-m1-m2*sin(x(3))^2+m2*cos(x(1)-x(3))*cos(x(3))*cos(x(1))-m2*cos(x(3))^2);
dx(1)=x(2);
dx(3)=x(4);
dx(2)=-g*sin(x(1))/l1-f2*sin(x(1)-x(3))/l1;
dx(4)=-g*sin(x(3))/l2-ax*cos(x(3))/l2-ay*sin(x(3))/l2;
end