clc;clear variables;close all;
% ###############################################

ri = input('please insert the inner radiuse: ');
k = input('please insert the thermal conductivity: ');
h = input('please insert the convection heat-transfer coefficient: ');
ti = input('please insert the inner tempruture: ');
tinf = input('please insert the infinite tempruture: ');
% the length og tube is l=1meter
l = 1;
ro = 0.025;
q = (2*pi*l*(ti-tinf))./((log(ro./ri)./k)+1./(ro.*h));
plot(ro,q);
critical_insulation_tickness = max(q);
