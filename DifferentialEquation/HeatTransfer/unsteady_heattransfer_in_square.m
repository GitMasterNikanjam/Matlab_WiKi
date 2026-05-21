% unsteady-state conduction in a square shape
clc;clear all;close all;
% dx & dy is value of increment of x-direction & y-direction
% for easy solving we assume dx=dy=0.001
dx=0.001;
% the length of shape is unit
% the initial tempreture of body is 400 degree
T=400*ones(100,100);
% the tempreture of free-stream is 25 degree
Tinf=25;
% the increment of time is 0.01
dt=0.01;
% BI=(h*dx)/k;
% FO=(alpha*dt)/((dx)^2);
BI=0.1;
FO=0.1;
for p=1:10000
    Tloop(1,1)=2*FO*(T(1,2)+T(2,1)-2*T(1,1)+2*BI*(Tinf-T(1,1)))+T(1,1);
    Tloop(1,100)=2*FO*(T(2,100)+T(1,99)-2*T(1,100)+2*BI*(Tinf-T(1,100)))+T(1,100);
    Tloop(100,1)=2*FO*(T(100,2)+T(99,1)-2*T(100,1)+2*BI*(Tinf-T(100,1)))+T(100,1);
    Tloop(100,100)=2*FO*(T(99,100)+T(100,99)-2*T(100,100)+2*BI*(Tinf-T(100,100)))+T(100,100);
    for i=2:99
       Tloop(1,i)=FO*(2*BI*(Tinf-T(1,i))+2*T(2,i)+T(1,i+1)+T(1,i-1)-4*T(1,i))+T(1,i);
       Tloop(i,1)=FO*(2*BI*(Tinf-T(i,1))+2*T(i,2)+T(i+1,1)+T(i-1,1)-4*T(i,1))+T(i,1);
       Tloop(100,i)=FO*(2*BI*(Tinf-T(100,i))+2*T(99,i)+T(100,i+1)+T(100,i-1)-4*T(100,i))+T(100,i);
       Tloop(i,100)=FO*(2*BI*(Tinf-T(i,100))+2*T(i,99)+T(i+1,100)+T(i-1,100)-4*T(i,100))+T(i,100);
    end
    for m=2:99
        for n=2:99
            Tloop(m,n)=FO*(T(m-1,n)+T(m,n+1)+T(m+1,n)+T(m,n-1)-4*T(m,n))+T(m,n);
        end
    end   
    T=Tloop;
    [x,y]=meshgrid(1:100,1:100);
    surf(x,y,T);
    colorbar
%  view([0,90])
  axis([0 100 0 100 0 400]);
    pause(0.0001);
end

