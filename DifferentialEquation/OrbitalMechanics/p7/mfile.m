clc;clear all;close all;
R=64*10^5;
x=[0 0 0 1.4*R 1.5*R 1*R 2*R 2*R 1.8*R];
y=[0 R 2*R 0 R 2*R 0 R 2*R];
xdot=[0 100 0 0 0 0 300 0 0];
ydot=zeros(1,9);
codition=[x' y' xdot' ydot'];
[T Y]=ode45(@fun,0:1:1500,[x y xdot ydot]);
for i=1:1:length(T)
    hold off
plot(Y(i,1),Y(i,10),'.');
hold on
plot(Y(i,2),Y(i,11),'.');
plot(Y(i,3),Y(i,12),'.');
plot(Y(i,4),Y(i,13),'.');
plot(Y(i,5),Y(i,14),'.');
plot(Y(i,6),Y(i,15),'.');
plot(Y(i,7),Y(i,16),'.');
plot(Y(i,8),Y(i,17),'.');
plot(Y(i,9),Y(i,18),'.');

    axis([-10^6 2*10^7 0 1.5*10^7]);
    pause(0.01);
end

%% ODE function (constants defined inside)
function dxdt = fun(~, state)
    G = 6.671e-11;
    M = 5.972e24;
    N = length(state) / 4;
    x = state(1:N);
    y = state(N+1:2*N);
    vx = state(2*N+1:3*N);
    vy = state(3*N+1:4*N);
    r = sqrt(x.^2 + y.^2);
    a_mag = -G * M ./ (r.^2 + eps);
    ax = a_mag .* (x ./ r);
    ay = a_mag .* (y ./ r);
    dxdt = [vx; vy; ax; ay];
end