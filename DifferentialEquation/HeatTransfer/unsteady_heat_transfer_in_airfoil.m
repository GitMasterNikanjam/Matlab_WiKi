% developed by mohammad nikanjam
% unseady heat transfer in a airfoil
clc;clear all;close all;
% the airfoil is naca 0012
t=0.12;
c=1;
% z=linspace(0,pi/2,101);
% x=sin(z);
x=0:0.01:1;
y=0.061:-0.001:-0.061;
y1=(t*c/0.2).*(0.2969.*sqrt(x./c)-0.1260.*(x./c)-0.3516.*(x./c).^2+...
    0.2843.*(x./c).^3-.1015.*(x./c).^4);
y2=-y1;
% m is number of line(horizental direction)
% n is number of row(vertical direction)
% the tempreture of free stream is -60 degree
Tinf=-60;
% the FO=BI=0.1
BI=0.1;
FO=0.1;
% the initial temprature of airfoil is 400 degree
i=0;
ii=0;
for n=1:length(x)
    for m=1:length(y)
        if y2(n)<y(m)&&y(m)<y1(n)
            T(m,n)=400;
        else
            T(m,n)=nan;
        end
    end
end
T(:,102)=nan;
T(2,31)=nan;
T(122,31)=nan;
Tloop=nan*ones(123,102);
for p=1:100
    for m=1:length(y)
        for n=1:length(x)+1
            if isnan(T(m,n))
                Tloop(m,n)=nan;
            elseif isnan(T(m,n))==0
    if isnan(T(m,n+1))&&isnan(T(m-1,n))
        % right and up is nan
        Tloop(m,n)=2*FO*(T(m+1,n)+T(m,n-1)-2*T(m,n)+2*BI*(Tinf-T(m,n)))+T(m,n);
    elseif isnan(T(m,n+1))&&isnan(T(m+1,n))
        % right and down is nan
            Tloop(m,n)=2*FO*(T(m-1,n)+T(m,n-1)-2*T(m,n)+2*BI*(Tinf-T(m,n)))+T(m,n);
        elseif isnan(T(m-1,n))&&isnan(T(m,n-1))
            % up and left is nan
            Tloop(m,n)=2*FO*(T(m+1,n)+T(m,n+1)-2*T(m,n)+2*BI*(Tinf-T(m,n)))+T(m,n);
    elseif isnan(T(m+1,n))&&isnan(T(m,n-1))
% down and left is nan
        Tloop(m,n)=2*FO*(T(m-1,n)+T(m,n+1)-2*T(m,n)+2*BI*(Tinf-T(m,n)))+T(m,n);
    elseif isnan(T(m,n+1))
        % right is nan
        Tloop(m,n)=FO*(2*BI*(Tinf-T(m,n))+2*T(m,n-1)+T(m+1,n)+T(m-1,n)-4*T(m,n))+T(m,n);
    elseif isnan(T(m-1,n))
        % up is nan
        Tloop(m,n)=FO*(2*BI*(Tinf-T(m,n))+2*T(m+1,n)+T(m,n+1)+T(m,n-1)-4*T(m,n))+T(m,n);
    elseif isnan(T(m,n-1))
        % left is nan
        Tloop(m,n)=FO*(2*BI*(Tinf-T(m,n))+2*T(m,n+1)+T(m+1,n)+T(m-1,n)-4*T(m,n))+T(m,n);
    elseif isnan(T(m+1,n))
        % down is nan
        Tloop(m,n)=FO*(2*BI*(Tinf-T(m,n))+2*T(m-1,n)+T(m,n+1)+T(m,n-1)-4*T(m,n))+T(m,n);
    elseif T(m+1,n)~=nan&&T(m-1,n)~=nan&&T(m,n+1)~=nan&&T(m,n-1)~=nan
        Tloop(m,n)=FO*(T(m-1,n)+T(m,n+1)+T(m+1,n)+T(m,n-1)-4*T(m,n))+T(m,n);
    end 
    end
        end
    end
    T=Tloop;
  i=i+1;
  if mod(i,20)==0
      ii=ii+1;
          Tplot{ii}=T;
  end
end
for ii=1:length(Tplot)
  [xp,yp]=meshgrid(linspace(0,1,length(x)+1),linspace(0.061,-0.061,length(y)));
    surf(xp,yp,Tplot{ii},'edgecolor','none');
    colorbar;
    axis equal
    view([0,90]);
  axis([0 1 -0.5 0.5]);
  frame(ii)=getframe(gcf);
%     pause(0.1);
end
movie2avi(frame,'heat transfer in naca_0012 airfoil','fps',10,'compression','none','quality',50);
