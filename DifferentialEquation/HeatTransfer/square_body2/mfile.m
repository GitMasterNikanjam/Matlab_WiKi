clc;clear all;close all;
% project = find tempreture on the surface of square body in 2d
% h is convection coefficient
% k is conduction coefficient 
% n*n is number of points that calculated by program
% tinf is tempreture for free stream
% tcent is tempreture for center of body
p=inputdlg({'n number that generate n*n points','conduction coefficient(k)',...
    'convection coefficient(h)','tempreture of free stream','tempreture of center point','rate of heat generation(qdot)'},'inputs',...
    1,{'21' '1' '100' '100' '500' '0'});
n=str2double(p{1});
k=str2double(p{2});
h=str2double(p{3});
tinf=str2double(p{4});
tcent=str2double(p{5});
qdot=str2double(p{6});
mesht(1,1:n)=tinf;
mesht(n,1:n)=tinf;
mesht(1:n,1)=tinf;
mesht(1:n,n)=tinf;
mesht(floor(n/2)+1,floor(n/2)+1)=tcent;
meshqdot(1:n,1:n)=-1;
meshqdot(2:n-1,2:n-1)=qdot;
meshr(1:n,1:n)=h;
meshr(2:n-1,2:n-1)=k;
mesh={mesht,meshr,meshqdot};
temp=mesh_solve(mesh);



