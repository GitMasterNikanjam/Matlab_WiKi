function dx=fun(t,x)
dx=zeros(1,8)';
G=6.671*10^(-11);
me=5.972*10^(24);
re=sqrt(x(1)^2+x(3)^2);
ms=1.98892*10^30;
rm=sqrt((x(1)-x(2))^2+(x(3)-x(4))^2);
dx(1)=x(5);
dx(2)=x(6);
dx(3)=x(7);
dx(4)=x(8);
dx(5)=(G*ms/(re^3))*(-x(1));
dx(6)=(G*me/(rm^3))*(x(1)-x(2));
dx(7)=(G*ms/(re^3))*(-x(3));
dx(8)=(G*me/(rm^3))*(x(3)-x(4));
end