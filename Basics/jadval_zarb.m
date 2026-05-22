clc;clear all;close all;
m=input('m ra vared konid ');
n=input('n ra vared konid ');
for ii=1:1:m
    for jj=1:n
       c(jj,ii)=jj*ii; 
    end
end
clc;
disp(['jadvale ',num2str(n),' dar ' , num2str(m) , '  shoma = ']);
disp(c);