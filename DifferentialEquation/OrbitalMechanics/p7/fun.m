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