% 3D Graphics: Sphere 
% Dr. P.Venkataraman 
format compact 
set(gcf,'Menubar','none','Name','Spheres', ... 
    'NumberTitle','off','Position',[10,350,400,300], ... 
    'Color',[0.2 0.3 0.4]); 
% first sphere 
h(1) = axes('Position',[0 0 1 1]); 
[Xs Ys Zs]=sphere(30);  % create data for sphere surface 
hs1 = surf(Xs, Ys, Zs);    % create sphere 
set(hs1,'EdgeColor','none', ... 
    'FaceColor','red', ... 
    'FaceAlpha','interp'); 
alpha('color'); 
alphamap('rampdown'); 
camlight(45,45); 
lighting phong 
hidden off 
axis square
% second 
h(2) = axes('Position',[0.1 0.1 0.5 0.5]);

[Xs Ys Zs]=sphere(20); 
hs2 = surf(Xs, Ys, Zs); 
set(hs2,'EdgeColor',[0.5 0.5 0.5], ... 
    'FaceColor','interp', ... 
    'FaceAlpha','interp'); 
alpha('color'); 
alphamap('rampdown'); 
camlight right; 
lighting phong 
hidden off 
axis equal

% third 
h(3)= axes('Position',[0.6 0.6 0.3 0.3]);

[Xs Ys Zs]=sphere(30); 
hs3 = surf(Xs, Ys, Zs); 
set(hs3,'EdgeColor','none', ... 
    'FaceColor','y', ... 
    'FaceLighting','phong', ... 
    'AmbientStrength',0.3, ... 
    'DiffuseStrength',0.8, ... 
    'SpecularStrength',0.9, ... 
    'SpecularExponent',25, ... 
    'BackFaceLighting','lit'); 
camlight left; 
hidden off

set(h,'Visible','off') 
axis square