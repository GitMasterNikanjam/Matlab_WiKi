clc;clear all;close all;
a=input('matris khod ra vared konid ');
[x y]=size(a);
for ii=1:x
    for jj=1:y
        c(jj,ii)=a(ii,jj);
        
    end
end
disp('taranahade shoma = ');
disp(c);