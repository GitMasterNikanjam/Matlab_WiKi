function dx=fun(t,x)
dx=zeros(36,1);
G=6.671*(10^(-11));
m=5.972*10^24;
for i=1:18
   dx(i)=x(18+i); 
end
fx=zeros(9,9);
fy=zeros(9,9);
r=zeros(9,9);
for i=1:9
    for j=1:9
    r(i,j)=sqrt((x(i)-x(j))^2+(x(9+i)-x(9+j))^2);
    if i==j
        fx(i,j)=0;
        fy(i,j)=0;
    else
    fx(i,j)=(G*m/((r(i,j)+120)^3))*(x(j)-x(i));
    fy(i,j)=(G*m/((r(i,j)+120)^3))*(x(9+j)-x(9+i));
    end
    end
    dx(18+i)=sum(fx(i,:));
    dx(27+i)=sum(fy(i,:));
end