% SHOWEXPHEAT  show Fourier sine series solution to a PDE initial-boundary
% value problem:
%   PDE   u_t = 9 u_xx                [ 0 < x < 1, t > 0 ]
%   IC    u(x,0) = phi(x) = e^x
%   BCs   u(0,t) = 0
%         u(1,t) = 0

x = 0:.0005:1;  % fine grid for plotting

% compute coefficients and show for a couple of N values
N = 200;
A = zeros(1,N);
for n=1:N
  A(n) = 2*n*pi * (1 - (-1)^n/exp(1));
  A(n) = A(n) / (1 + (n*pi)^2);
end

% show initial condition over partial sum of its Fourier sine series
phi = zeros(size(x));
for n=1:N
  phi = phi + A(n) * sin(n * pi * x);
  if n==20
    plot(x,phi), hold on
  end
end
plot(x,phi,'r',x,exp(-x),'g'), hold off
legend('N=20 Fourier sum','N=200 Fourier sum','exact \phi(x)=e^x')

% show 'frames of movie' at different times (also partial sums)
figure(2)
N = 20;         % how far to take partial sum
for t = [0.0001 0.001 0.01 0.025 0.05]
  u = zeros(size(x));
  for n=1:N
    u = u + A(n) * exp(-9 * ((n*pi)^2) * t) * sin(n * pi * x);
  end
  plot(x,u), hold on
end
hold off, grid on
title('solution  u(x,t)  at t = 0.0001, 0.001, 0.01, 0.025, 0.05')

