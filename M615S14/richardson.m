function U = richardson(J,N,tf)
% RICHARDSON  The USELESS "Richardson" scheme
%   U(n+1,j) - U(n-1,j)     U(n,j+1) - 2 U(n,j) + U(n,j-1)
%   -------------------  =  ------------------------------
%           dt                          dx^2
% which has O(dt^2,dx^2) truncation error but which is UNSTABLE.
% Uses a cheat to get started, namely a bit of exact solution.
% Examples: >> richardson(10,10,0.1);   % already shows problems
%           >> richardson(20,20,0.1);   % much worse
%           >> richardson(20,160,0.1);  % typical horror
% DO NOT USE THIS CODE!

dt = tf / N;    t = 0:dt:tf;
dx = 1.0 / J;   x = 0:dx:1;

U = zeros(N+1,J+1);    % allocate space
U(1,:) = sin(2*pi*x);  % set initial condition at t = 0
U(2,:) = exp(-4*pi^2*dt) * sin(2*pi*x); % value of exact solution at t = dt

% numerically-approximate, measuring error as we go
mu = dt / dx^2         % report mu
err = zeros(1,N+1);
for n = 2:N
  for j = 2:J
    U(n+1,j) = U(n-1,j) + 2 * mu * (U(n,j+1) - 2 * U(n,j) + U(n,j-1));
  end
  uexact = exp(-4*pi^2*(n*dt)) * sin(2*pi*x);  % exact at this time step
  err(n+1) = max(abs(U(n+1,:) - uexact));
end

figure(1), mesh(x,t,U), xlabel x, ylabel t, zlabel U

figure(2), semilogy(t,err), xlabel t, grid on
title('error |U-u| as a function of time')
