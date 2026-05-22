%     sample main program to check stdatm
%     - to test MATLAB, October 2001
%     w.h. mason, Feb. 27, 1994
%     Dept. of Aerospace and Ocean Engineering
%     Blacksburg, VA 24061
%     mason@aoe.vt.edu

%     this is a sample main showing how to
%     call stdatmf

clear
k = 1;
disp([' '])
disp(['  1976 Standard Atmosphere'])
disp([' '])
Z=input('  Enter Altitude, in feet, ');
disp([' '])

[T,R,P,A,MU,TS,RR,PP,RM,QM,KK] = stdatmf(Z,k);

 if (KK==1)
  disp('And for my next trick, I will go into orbit!!!');
  disp('Altitude too high, try again!!');
  break
end

disp(['  Altitude, Z = ',num2str(Z), ' ft'])
disp([' '])
disp(['  Temperature,        T  = ',num2str(T), ' deg R'])
disp(['  Pressure,           P  = ',num2str(P), ' psf'])
disp(['  Density,            R  = ',num2str(R), ' slugs/ft^3'])
disp(['  Speed of Sound,     A  = ',num2str(A), ' ft/sec'])
disp(['  Coef. of Viscosity, MU = ',num2str(MU), ' slugs/ft/sec'])
disp(['  T/Tsl,              TS = ',num2str(TS), '']) 
disp(['  RHO/RHOsl,          RR = ',num2str(RR), ' '])
disp(['  P/Psl,              PP = ',num2str(PP), ' '])
disp(['  RM = ',num2str(RM), ' Reynolds number/Mach/ft'])
disp(['  QM = ',num2str(QM), ' psf, dyn. press./Mach^2'])
disp([' '])
   