function [tt,zz] = rk4(f,eta,t0,tf,N)
% RK4  Solve   u' = f(u,t),  u(t0) = eta  for u(t) on the interval [t0,tf] with
% N steps of the classical Runge-Kutta 4th-order method.
% Usage:  [tt,zz] = rk4(f,eta,t0,tf,N)

dt = (tf - t0) / N;  tt = t0:dt:tf;  % row vector of times
eta = eta(:);  s = length(eta);      % force to be column vector
zz = zeros(s,N+1);  zz(:,1) = eta;   % jth column is U at t_{j-1}

for j = 1:N                          % RK4 is (5.33) in LeVeque
    t = tt(j);
    Y1 = zz(:,j);
    Y2 = Y1 + (dt/2) * f(Y1,t);
    Y3 = Y1 + (dt/2) * f(Y2,t + dt/2);
    Y4 = Y1 + dt * f(Y3,t + dt/2);
    zz(:,j+1) = Y1 + (dt / 6) * ...
        ( f(Y1,t) + 2 * f(Y2,t+dt/2) + 2 * f(Y3,t+dt/2) + f(Y4,t+dt) );
end
