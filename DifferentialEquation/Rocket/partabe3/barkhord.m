function [v it d]=barkhord(t,x)
y=evalin('base','y');
t=evalin('base','t');
y=interp1(t,y,x(1));
v=x(2)-y;
it=1;
d=0;
end