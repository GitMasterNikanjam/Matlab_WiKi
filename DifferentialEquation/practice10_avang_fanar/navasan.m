function dx=navasan(t,x)
dx=[0 0]';
dx(1)=x(2);
dx(2)=-9.81*sind(x(1))-(2000/40)*(sqrt(4*(1-cosd(x(1))^2)+(1+2*sind(x(1)))^2)-1)...
    *cosd(x(1)-atand(2*(1-cosd(x(1)))/(1+2*sind(x(1)))));
end