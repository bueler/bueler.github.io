function [tt,zz] = forwardeuler(f,eta,t0,tf,N)
% FORWARDEULER  Solve   u' = f(u,t),  u(t0) = eta  for u(t) on the interval
% [t0,tf] with N steps of the forward Euler method.
% Usage: [tt,zz] = forwardeuler(f,eta,t0,tf,N)

dt = (tf - t0) / N;  tt = t0:dt:tf;  % row vector of times
eta = eta(:);  s = length(eta);      % force to be column vector
zz = zeros(s,N+1);  zz(:,1) = eta;   % jth column is U at t_{j-1}

for j = 1:N                          % forward Euler is (5.19) in LeVeque
    zz(:,j+1) = zz(:,j) + dt * f(zz(:,j),tt(j));
end
