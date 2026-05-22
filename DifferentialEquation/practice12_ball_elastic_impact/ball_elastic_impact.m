function ball_elastic_impact
x=0:0.01:100;
y=input('please insert your function of wall : ');
window=figure('name','ball_elastic_impact');
set(window,'numbertitle','off','color','w','menubar','none');
fill([x x(end) 0],[y 0 0],'k');
axis off
axis([0 x(end) 0  y(end)]);
op=odeset('event',@barkhord);
[T,Y]=ode45(@harekat,0:0.01:10,[10 10 0 0],op);
end
function [v it d]=barkhord(t,x)
v=x(2)-y(x(1));
it=1;
d=-1;
end
function dx=harekat(t,x)
dx=[0 0 0 0]';
dx(1)=x(3);
dx(2)=x(4);
dx(3)=0;
dx(4)=-9.81;
end