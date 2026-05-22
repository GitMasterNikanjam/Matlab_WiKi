function bouncing_ball
    op=odeset('event',@barkhord,'initialstep',0.01,'maxstep',0.02);
    initialv=0;
    initialy=6;
    z=[];
    t=[];
    te=0;
for ii=1:15
    [T,Y,te]=ode45(@harekat,te:0.01:30,[initialy initialv],op);
    z=[z,Y(:,1)']; 
    t=[t,T(:,1)'];
    if initialv==0
      initialv=10;  
    else
    initialv=0.7*initialv;
    end
    initialy=0;
end
  masir=plot(t(1),z(1));
    hold on;
    toop= plot(t(1),z(1),'-ok','markerfacecolor','r','markersize',10);
  xlabel('time');
  ylabel('height');
  title('events in ode45');
  
   axis equal
for jj=2:length(t)
  set(toop,'xdata',t(jj),'ydata',z(jj));
  set(masir,'xdata',t(1:jj),'ydata',z(1:jj));
  
   pause(0.01);
end

end
 function [v,it,d]=barkhord(t,x)
        v=x(1)-0;
        it=1;
        d=-1;
 end
 function dx=harekat(t,x)
 dx=[0 0]';
 dx(1)=x(2);
 dx(2)=-9.81;
 end