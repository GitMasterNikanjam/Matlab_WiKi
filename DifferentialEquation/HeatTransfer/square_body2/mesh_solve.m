function temp=mesh_solve(mesh)
mesht=mesh{1};
meshr=mesh{2};
meshqdot=mesh{3};
n=lenght(mesht);
A(1:n,1:n)=0;
B(1:n,1:n)=0;
for i=2:n-1
    for j=2:n-1
        if mesht(i,j)==0
            A(i,j)=meshr(i,j+1)+meshr(i,j-1)+meshr(i+1,j)+meshr(i-1,j);
            A(i,j+1)=-meshr(i,j+1);
            A(i,j-1)=-meshr(i,j-1);
            A(i,j)=-meshr(i+1,j);
            A(i,j)=-meshr(i-1,j);
            B(i,j)=meshqdot(i,j);
        else
            A(i,j)=1;
            B(i,j)=mesht(i,j);
        end
        
    end
    
    
end

end