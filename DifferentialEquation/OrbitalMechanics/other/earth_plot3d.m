clc;clear all;close all;
p=figure();
stars=imread('stars.jpg');
set(p,'color','k','numbertitle','off');
ha1=axes('position',[0 0 1 1]);
imshow(stars);
ha2=axes('position',[0 0 1 1]);
axis 
hold on;
%opd is orbital period days
opd=[88.0	224.7	365.2	527.3	687.0	4331	10747	30589	59800	90588];
% ov is orbital velocity in km/s
ov=[47.9	35.0	29.8	1.0	24.1	13.1	9.7	6.8	5.4	4.7];
%oi is orbital inclination in degree
oi=[7.0	       3.4	0.0	5.1	1.9	1.3	2.5	0.8	1.8	17.2];
%at is axial tilt in degree
at=[0.01	177.4	23.4	6.7	25.2	3.1	26.7	97.8	28.3	122.5];
%rph is rotation period in hours
rph=[1407.6	-5832.5	23.9	655.7	24.6	9.9	10.7	-17.2	16.1	-153.3];
%mds=mean distance from sun
%----------------------------------------------------------------
%sun
[x_sun y_sun z_sun]=sphere;
r_sun=696*10^3*50;
m_sun=1.9891*10^30;
x_sun=r_sun*x_sun;
y_sun=r_sun*y_sun;
z_sun=r_sun*z_sun;
im_sun=imread('sun.png');
h_sun=surf(x_sun,y_sun,z_sun);
set(h_sun,'cdata',im_sun,'facecolor','texturemap','edgecolor','none');
axis off
axis equal




%-----------------------------------------------------------------
%mercury
[x_mercury y_mercury z_mercury]=sphere;
r_mercury=2439.64*1000;
m_mercury=3.302*10^23;
mds_mercury=57909175;
x_mercury=r_mercury*x_mercury;
y_mercury=r_mercury*y_mercury;
z_mercury=r_mercury*z_mercury;
im_mercury=imread('mercury.png');
h_mercury=surf(x_mercury,y_mercury,z_mercury);
set(h_mercury,'cdata',im_mercury,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_mercury=opd(1);
ov_mercury=ov(1);
oi_mercury=oi(1);
at_mercury=at(1);
rph_mercury=rph(1);



%------------------------------------------------------------------
%venus
[x_venus y_venus z_venus]=sphere;
r_venus=6051.59*1000;
m_venus=4.8690*10^24;
mds_venus=108208930;
x_venus=r_venus*x_venus;
y_venus=r_venus*y_venus;
z_venus=r_venus*z_venus;
im_venus=imread('venus.png');
h_venus=surf(x_venus,y_venus,z_venus);
set(h_venus,'cdata',im_venus,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_venus=opd(2);
ov_venus=ov(2);
oi_venus=oi(2);
at_venus=at(2);
rph_venus=rph(2);





%-----------------------------------------------------------------
%earth
[x_earth y_earth z_earth]=sphere;
z_earth=flipud(z_earth);
r_earth=6378.1*1000;
m_earth=5.9742*10^24;
mds_earth=149597890;
x_earth=r_earth*x_earth;
y_earth=r_earth*y_earth;
z_earth=r_earth*z_earth;
im_earth=imread('earth.png');
h_earth=surf(x_earth,y_earth,z_earth);
set(h_earth,'cdata',im_earth,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_earth=opd(3);
ov_earth=ov(3);
oi_earth=oi(3);
at_earth=at(3);
rph_earth=rph(3);

%--------------------------------------------------------------------
%mars
[x_mars y_mars z_mars]=sphere;
r_mars=3397*1000;
m_mars=6.4191*10^23;
mds_mars=227936640;
x_mars=r_mars*x_mars;
y_mars=r_mars*y_mars;
z_mars=r_mars*z_mars;
im_mars=imread('mars.png');
h_mars=surf(x_mars,y_mars,z_mars);
set(h_mars,'cdata',im_mars,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_mars=opd(4);
ov_mars=ov(4);
oi_mars=oi(4);
at_mars=at(4);
rph_mars=rph(4);



%--------------------------------------------------------------------
%jupiter
[x_jupiter y_jupiter z_jupiter]=sphere;
r_jupiter=71492.68*100;
m_jupiter=1.8987*10^27;
mds_jupiter=778412010;
x_jupiter=r_jupiter*x_jupiter;
y_jupiter=r_jupiter*y_jupiter;
z_jupiter=r_jupiter*z_jupiter;
im_jupiter=imread('jupiter.png');
h_jupiter=surf(x_jupiter,y_jupiter,z_jupiter);
set(h_jupiter,'cdata',im_jupiter,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_jupiter=opd(5);
ov_jupiter=ov(5);
oi_jupiter=oi(5);
at_jupiter=at(5);
rph_jupiter=rph(5);





%---------------------------------------------------------------------
%saturn
[x_saturn y_saturn z_saturn]=sphere;
r_saturn=60267.14*100;
m_saturn=1.9891*10^30;
mds_saturn=1426725400;
x_saturn=r_saturn*x_saturn;
y_saturn=r_saturn*y_saturn;
z_saturn=r_saturn*z_saturn;
im_saturn=imread('saturn.png');
h_saturn=surf(x_saturn,y_saturn,z_saturn);
set(h_saturn,'cdata',im_saturn,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_saturn=opd(6);
ov_saturn=ov(6);
oi_saturn=oi(6);
at_saturn=at(6);
rph_saturn=rph(6);


%---------------------------------------------------------------------
%uranus
[x_uranus y_uranus z_uranus]=sphere;
r_uranus=25557.25*1000;
m_uranus=8.6849*10^25;
mds_uranus=2870972200;
x_uranus=r_uranus*x_uranus;
y_uranus=r_uranus*y_uranus;
z_uranus=r_uranus*z_uranus;
im_uranus=imread('uranus.png');
h_uranus=surf(x_uranus,y_uranus,z_uranus);
set(h_uranus,'cdata',im_uranus,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_uranus=opd(7);
ov_uranus=ov(7);
oi_uranus=oi(7);
at_uranus=at(7);
rph_uranus=rph(7);



%----------------------------------------------------------------------
%neptune
[x_neptune y_neptune z_neptune]=sphere;
r_neptune=24766.36*1000;
m_neptune=1.0244*10^26;
mds_neptune=4498252900;
x_neptune=r_neptune*x_neptune;
y_neptune=r_neptune*y_neptune;
z_neptune=r_neptune*z_neptune;
im_neptune=imread('neptune.png');
h_neptune=surf(x_neptune,y_neptune,z_neptune);
set(h_neptune,'cdata',im_neptune,'facecolor','texturemap','edgecolor','none');
axis off
axis equal
opd_neptune=opd(8);
ov_neptune=ov(8);
oi_neptune=oi(8);
at_neptune=at(8);
rph_neptune=rph(8);



%-------------------------------------------------------------------
%pluto
[x_pluto y_pluto z_pluto]=sphere;



%--------------------------------------------------------------------
axis image
rotate3d on
axis([-mds_neptune mds_neptune -mds_neptune mds_neptune -mds_neptune mds_neptune]);
theta=0:0.01:2*pi;
x=cos(theta);
y=sin(theta);
z=0*x;
p1=plot3(mds_mercury*x,mds_mercury*y*cos(oi_mercury),-mds_mercury*y*sin(oi_mercury),'r');
p2=plot3(mds_venus*x,mds_venus*y*cos(oi_venus),-mds_venus*y*sin(oi_venus),'b');
p3=plot3(mds_earth*x,mds_earth*y*cos(oi_earth),-mds_earth*y*sin(oi_earth),'c');
p4=plot3(mds_mars*x,mds_mars*y*cos(oi_mars),-mds_mars*y*sin(oi_mars),'c');
p5=plot3(mds_jupiter*x,mds_jupiter*y*cos(oi_jupiter),-mds_jupiter*y*sin(oi_jupiter),'c');
p6=plot3(mds_saturn*x,mds_saturn*y*cos(oi_saturn),-mds_saturn*y*sin(oi_saturn),'c');
p7=plot3(mds_uranus*x,mds_uranus*y*cos(oi_uranus),-mds_uranus*y*sin(oi_uranus),'c');
p8=plot3(mds_neptune*x,mds_neptune*y*cos(oi_neptune),-mds_neptune*y*sin(oi_neptune),'c');
camzoom(2)
ii=0;
while 1==1
    ii=ii+3;
    set(h_mercury,'xdata',x_mercury+mds_mercury*cos(ii/opd_mercury),'ydata',y_mercury+mds_mercury*sin(ii/opd_mercury)*cos(oi_mercury),'zdata',z_mercury-mds_mercury*sin(ii*360/opd_mercury)*sin(oi_mercury));
    set(h_venus,'xdata',x_venus+mds_venus*cos(ii/opd_venus),'ydata',y_venus+mds_venus*sin(ii/opd_venus)*cos(oi_venus),'zdata',z_venus-mds_venus*sin(ii*360/opd_venus)*sin(oi_venus));
    set(h_earth,'xdata',x_earth+mds_earth*cos(ii/opd_earth),'ydata',y_earth+mds_earth*sin(ii/opd_earth)*cos(oi_earth),'zdata',z_earth-mds_earth*sin(ii*360/opd_earth)*sin(oi_earth));
    set(h_mars,'xdata',x_mars+mds_mars*cos(ii/opd_mars),'ydata',y_mars+mds_mars*sin(ii/opd_mars)*cos(oi_mars),'zdata',z_mars-mds_mars*sin(ii*360/opd_mars)*sin(oi_mars));
    set(h_jupiter,'xdata',x_jupiter+mds_jupiter*cos(ii/opd_jupiter),'ydata',y_jupiter+mds_jupiter*sin(ii/opd_jupiter)*cos(oi_jupiter),'zdata',z_jupiter-mds_jupiter*sin(ii*360/opd_jupiter)*sin(oi_jupiter));
    set(h_saturn,'xdata',x_saturn+mds_saturn*cos(ii/opd_saturn),'ydata',y_saturn+mds_saturn*sin(ii/opd_saturn)*cos(oi_saturn),'zdata',z_saturn-mds_saturn*sin(ii*360/opd_saturn)*sin(oi_saturn));
    set(h_uranus,'xdata',x_uranus+mds_uranus*cos(ii/opd_uranus),'ydata',y_uranus+mds_uranus*sin(ii/opd_uranus)*cos(oi_uranus),'zdata',z_uranus-mds_uranus*sin(ii*360/opd_uranus)*sin(oi_uranus));
    set(h_neptune,'xdata',x_neptune+mds_neptune*cos(ii/opd_neptune),'ydata',y_neptune+mds_neptune*sin(ii/opd_neptune)*cos(oi_neptune),'zdata',z_neptune-mds_neptune*sin(ii*360/opd_neptune)*sin(oi_neptune));
pause(0.001);
end
% while 1==1
%     g=0;
% for i=1:length(a)
%     g=g+0.04;
%     x1=x*cos(-6)-z*sin(-6);
%     z1=x*sin(-6)+z*cos(-6);
%     x2=x1*cos(g)-y*sin(g);
%     y2=x1*sin(g)+y*cos(g);
%     set(h,'xdata',x2+a(i),'ydata',y2+b(i),'zdata',z1);
% %     light('Position',[0 0 0],'Style','infinite');
% % campos([25,0,0]);
% % camtarget([a(i),b(i),0]);
% % camroll(10)
% pause(0.05);   
% end
% end