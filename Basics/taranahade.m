clc;clear vriables;close all;
% ###############################################

a = input('insert your matrix: ');
[x y] = size(a);

for ii = 1:x
    for jj = 1:y
        c(jj,ii) = a(ii,jj);
    end
end

disp('Transposition is:  ');
disp(c);