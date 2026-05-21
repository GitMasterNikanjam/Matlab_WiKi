function temp=mesh_solve(mesh)
mesht=mesh{1};
meshr=mesh{2};
meshq=mesh{3};
n=length(mesht);
B(1:(n-2)^2,1)=0;
A((n-2)^2,(n-2)^2)=0;
for i=2:n-1
    for j=2:n-1
        if meshq(i-1,j)==-1
            B((i-2)*(n-2)+j-1)=-mesht(i-1,j)*meshr(i-1,j)+B((i-2)*(n-2)+j-1);
        else
            if isnan(mesht(i-1,j))
            A((i-2)*(n-2)+(j-1),(i-3)*(n-2)+j-1)=meshr(i-1,j);
            A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1)=-meshr(i-1,j)+ A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1);

            else
            B((i-2)*(n-2)+j-1)=-mesht(i-1,j)*meshr(i-1,j)+B((i-2)*(n-2)+j-1);
            if isnan(mesht(i,j))==0
                 B((i-2)*(n-2)+j-1)=mesht(i,j)*meshr(i-1,j)+B((i-2)*(n-2)+j-1);
            end
            end
        end
        if meshq(i,j-1)==-1
            B((i-2)*(n-2)+j-1)=-mesht(i,j-1)*meshr(i,j-1)+B((i-2)*(n-2)+j-1);
        else
            if isnan(mesht(i,j-1))
            A((i-2)*(n-2)+(j-1),(i-2)*(n-2)+j-2)=meshr(i,j-1);
            A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1)=-meshr(i,j-1)+ A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1);
            else
            B((i-2)*(n-2)+j-1)=-mesht(i,j-1)*meshr(i,j-1)+B((i-2)*(n-2)+j-1); 
            if isnan(mesht(i,j))==0
                  B((i-2)*(n-2)+j-1)=mesht(i,j)*meshr(i,j-1)+B((i-2)*(n-2)+j-1);
            end
            end
        end
        if meshq(i+1,j)==-1
             B((i-2)*(n-2)+j-1)=-mesht(i+1,j)*meshr(i+1,j)+B((i-2)*(n-2)+j-1);
        else
            if isnan(mesht(i+1,j))
             A((i-2)*(n-2)+(j-1),(i-1)*(n-2)+j-1)=meshr(i+1,j);
             A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1)=-meshr(i+1,j)+ A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1);
            else
             B((i-2)*(n-2)+j-1)=-mesht(i+1,j)*meshr(i+1,j)+B((i-2)*(n-2)+j-1);
             if isnan(mesht(i,j))==0
                 B((i-2)*(n-2)+j-1)=mesht(i,j)*meshr(i+1,j)+B((i-2)*(n-2)+j-1);
             end
            end
        end
        if meshq(i,j+1)==-1
           B((i-2)*(n-2)+j-1)=-mesht(i,j+1)*meshr(i,j+1)+B((i-2)*(n-2)+j-1);
        else
            if isnan(mesht(i,j+1))
           A((i-2)*(n-2)+(j-1),(i-2)*(n-2)+j)=meshr(i,j+1);
           A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1)=-meshr(i,j+1)+ A((i-2)*(n-2)+j-1,(i-2)*(n-2)+j-1);
            else
           B((i-2)*(n-2)+j-1)=-mesht(i,j+1)*meshr(i,j+1)+B((i-2)*(n-2)+j-1);
           if isnan(mesht(i,j))==0
              B((i-2)*(n-2)+j-1)=mesht(i,j)*meshr(i,j+1)+B((i-2)*(n-2)+j-1);
           end
            end
        end        
    end
end
A(5,:)=[];
A(:,5)=[];
B(5)=[];
assignin('base','A',A);
assignin('base','B',B);
T=A\B;
T(6:end+1)=T(5:end);
T(5)=500;
for i=2:n-1
    for j=2:n-1
        mesht(i,j)=T((i-2)*(n-2)+j-1);
    end
   
end
temp=mesht;

end
