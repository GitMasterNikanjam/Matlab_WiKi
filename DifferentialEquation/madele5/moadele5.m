function dx=moadele5(t,x,tf,f)
dx=0;
f=interp1(tf,f,t);
dx=-x+f;
end