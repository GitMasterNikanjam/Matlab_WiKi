clc;clear all;close all;
syms t
h=2:1:200;
for ii=1:2
 t= solve((0.8*2000)-h(ii)*(t-293)-0.5*5.67*(10^(-8))*(t^4-303^4));
 t(1)
end
 
