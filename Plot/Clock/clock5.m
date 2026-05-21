function saat5
window=figure('name','saate man');
set(window,'numbertitle','off','color','w','resize','off','menubar','none')
set(window,'closerequestfcn',@window_exit);
theta=0:0.01:2*pi;
plot(9*cos(theta),9*sin(theta),'linewidth',8,'color','k');
hold on
axis off
axis([-10 10 -10 10]);
axis square
plot(8.1*cos(theta),8.1*sin(theta),'color','k');
plot(8.5*cos(theta),8.5*sin(theta),'color','k');
theta=linspace(0,2*pi,61);
plot([8.1*cos(theta);8.5*cos(theta)],[8.1*sin(theta);8.5*sin(theta)],'k')
theta=linspace(0,2*pi,13);
plot([7.7*cos(theta);8.5*cos(theta)],[7.7*sin(theta);8.5*sin(theta)],'k','linewidth',5)
text(0,4,'\it nike','fontsize',10,'horizontalalignment','center');
a=1:12;
theta=pi/3:-pi/6:-3*pi/2;
text(6.5*cos(theta),6.5*sin(theta),num2str(a'),'horizontalalignment','center','verticalalignment','middle','fontsize',22);
xh=[-0.2 0.2 0.2 0 -0.2 -0.2];
yh=[-1 -1 3 4 3 -1];
xm=[-0.2 0.2 0.2 0 -0.2 -0.2];
ym=[-2 -2 5.5 7 5.5 -2];
xs=[-0.1 0.1 0.1 0 -0.1 -0.1];
ys=[-2 -2 6 7 6 -2];
m=fill(xm,ym,'b');
s=fill(xs,ys,'k');
h=fill(xh,yh,'g');
time=clock;
ts=time(6);
tm=time(5);
th=mod(time(4),12);
set(h,'xdata',xh*cos(-th*pi/6-tm*pi/360)-yh*sin(-th*pi/6-tm*pi/360),'ydata',xh*sin(-th*pi/6-tm*pi/360)...
    +yh*cos(-th*pi/6-tm*pi/360));
set(s,'xdata',xs*cos(-ts*pi/30)-ys*sin(-ts*pi/30),'ydata',xs*sin(-ts*pi/30)...
    +ys*cos(-ts*pi/30));
set(m,'xdata',xm*cos(-tm*pi/30-ts*pi/1800)-ym*sin(-tm*pi/30-ts*pi/1800),'ydata',xm*sin(-tm*pi/30-ts*pi/1800)...
    +ym*cos(-tm*pi/30-ts*pi/1800));
theta=0:0.01:2*pi;
fill(0.6*cos(theta),0.6*sin(theta),'r');
b=timer('timerfcn',@minute,'period',2,'executionmode','fixedrate');
a=timer('timerfcn',@secend,'period',1,'executionmode','fixedrate');
c=timer('timerfcn',@hour,'period',60,'executionmode','fixedrate');
start(a)
start(b)
start(c)
    function minute(varargin)
        time1=clock;
        tm=time1(5);
       set(m,'xdata',xm*cos(-tm*pi/30-ts*pi/1800)-ym*sin(-tm*pi/30-ts*pi/1800),'ydata',xm*sin(-tm*pi/30-ts*pi/1800)...
    +ym*cos(-tm*pi/30-ts*pi/1800));
    end
    function secend(varargin)
        time2=clock;
        ts=time2(6);
        set(s,'xdata',xs*cos(-ts*pi/30)-ys*sin(-ts*pi/30),'ydata',xs*sin(-ts*pi/30)+ys*cos(-ts*pi/30));
   pause(time2(6)-floor(time2(6)));
    end
    function hour(varargin)
        time3=clock;
        th=time3(4);
        set(h,'xdata',xh*cos(-th*pi/6-tm*pi/360)-yh*sin(-th*pi/6-tm*pi/360),'ydata',xh*sin(-th*pi/6-tm*pi/360)...
    +yh*cos(-th*pi/6-tm*pi/360)); 
    end

    function window_exit(varargin)
        closereq 
        stop(a)
        stop(b)
        stop(c)
        delete(a)
        delete(b)
        delete(c)
    end
end