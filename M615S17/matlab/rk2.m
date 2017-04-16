function [tt,zz] = rk2(f,eta,t0,tf,N)
% RK2  Solve   u' = f(u,t),  u(t0) = eta  for u(t) on the interval [t0,tf] with
% N steps of the classical Runge-Kutta 2nd-order method (explicit midpoint rule).
% Usage:  [tt,zz] = rk2(f,eta,t0,tf,N)

dt = (tf - t0) / N;  tt = t0:dt:tf;  % row vector of times
eta = eta(:);  s = length(eta);      % force to be column vector
zz = zeros(s,N+1);  zz(:,1) = eta;   % jth column is U at t_{j-1}

for j = 1:N                          % RK2 is (5.30) in LeVeque
    Ustar = zz(:,j) + (dt/2) * f(zz(:,j),tt(j));
    zz(:,j+1) = zz(:,j) + dt * f(Ustar,tt(j)+dt/2);
end
