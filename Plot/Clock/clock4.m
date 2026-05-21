function saat4
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


    function window_exit(varargin)
        closereq
        
        
    end
end