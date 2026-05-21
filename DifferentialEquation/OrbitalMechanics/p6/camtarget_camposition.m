surf(peaks)
axis vis3d off
for x = -200:5:200
    camtarget([25 38 8]);
    campos([x,50,10])
    drawnow
    pause(0.1)
end