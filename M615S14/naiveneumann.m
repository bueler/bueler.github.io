function U = naiveneumann(J,tf)
% NAIVENEUMANN solves a heat problem with Neumann boundary conditions at
% both ends, by an explicit scheme.  The problem:
%   u_t = k u_xx
%   u_x(0,t) = u_x(1,t) = 0
%   u(x,0) = cos(2 pi x) + cos(5 pi x)
% where k = .01.  The exact solution is known, namely
%   u(x,t) = exp(- 4 pi^2 k t) cos(2 pi x) + exp(- 25 pi^2 k t) cos(5 pi x)
% Produces two figures.  Figure 1 shows approximate solution at final
% time.  Figure 2 shows time-dependent error and time-dependent
% estimated thermal energy, \int_0^1 u dx, which should be constant
% because the homogeneous Neumann boundary conditions correspond to
% insulation.
%
% Usage:
%   U = naiveneumann(J,tf)
% Example:
%   >> naiveneumann(10,2.0);

dx = 1 / J;

k = 0.01;
dt = 0.5 * dx^2 / k;
N = ceil(tf / dt)
dt = tf / N;

mu = k * dt / dx^2;

err = zeros(1,N+1);
H = err;
t = dt * (0:N);

x = 0:dx:1;  % J+1 points
U = cos(2 * pi * x) + cos(5 * pi * x);

H(1) = 0.5 * dx * sum(U(1:J) + U(2:J+1));
for n = 1:N
  Unew = U;  % allocates by copying
  Unew(2:J) = U(2:J) + mu * (U(3:J+1) - 2 * U(2:J) + U(1:J-1));
  Unew(1) = Unew(2);    % naive way of enforcing Neumann
  Unew(J+1) = Unew(J);  % ditto
  U = Unew;
  H(n+1) = 0.5 * dx * sum(U(1:J) + U(2:J+1));
  c2 = exp(- 4 * pi^2 * k * t(n+1));
  c5 = exp(- 25 * pi^2 * k * t(n+1));
  uexact = c2 * cos(2 * pi * x) + c5 * cos(5 * pi * x);
  err(n+1) = max(abs(U - uexact));
end

figure(1)
plot(x,U,'ko-'),  xlabel('x'),  title('approx to u(x,t_f)'), grid on

figure(2)
subplot(2,1,1),  semilogy(t,err,'k'),  xlabel('t'),  ylabel('max |U - u|'),  grid on
subplot(2,1,2),  plot(t,H,'k'),  xlabel('t'),  ylabel('energy'),  grid on
