function U = neumann(J,tf,naive)
% NEUMANN solves a heat problem with Neumann boundary conditions at
% both ends, by an explicit scheme.  The problem:
%   u_t = k u_xx
%   u_x(0,t) = u_x(1,t) = 0
%   u(x,0) = cos(2 pi x) + cos(5 pi x)
% where k = .01.  The exact solution is known, namely
%   u(x,t) = exp(- 4 pi^2 k t) cos(2 pi x) + exp(- 25 pi^2 k t) cos(5 pi x)
% Produces three-part figure showing approximate solution at final
% time, time-dependent error, and time-dependent estimated thermal energy.
% (Note  H = \int_0^1 u dx  is thermal energy, which should be constant
% because the homogeneous Neumann boundary conditions correspond to
% insulation.)
%
% Usage:
%   U = neumann(J,tf,naive)
% where J is number of subintervals, tf is final time, and if  naive==true  then
% apply Neumann boundary conditions naively, whereas if  naive==false  [default]
% then apply them more smartly by having computed temps on the staggered grid.
%
% Examples:
%   >> neumann(50,2.0,true);    % large error, and loss of energy
%   >> neumann(500,2.0,true);   % error reduced only by 10; still loss of energy
%   >> neumann(50,2.0);         % smaller error and no loss of energy
%   >> neumann(500,2.0);        % error reduced by 100, as its O(dx^2) in fact

if nargin<3,  naive = false;  end

dx = 1 / J;              % in any case, J subintervals of length dx

k = 0.01;
dt = 0.5 * dx^2 / k;     % so  mu = 1/2
N = ceil(tf / dt);
dt = tf / N;             % so  N dt = tf  exactly and  mu <= 1/2
mu = k * dt / dx^2;
fprintf('  doing N=%d steps of length dt=%.3f, with mu=%.3f\n',N,dt,mu)

% time-dependent stuff allocated
t = dt * (0:N);
err = zeros(1,N+1);
H = err;

% regular and staggered grids
if naive
  x = 0:dx:1;                                % J+1 points
else
  x = dx/2:dx:(1-dx/2);                      % J points
end
U = cos(2 * pi * x) + cos(5 * pi * x);       % initial values

% initial energy
if naive
  H(1) = 0.5 * dx * sum(U(1:J) + U(2:J+1));  % trapezoid rule
else
  H(1) = dx * sum(U);                        % midpoint rule
end

% time-stepping loop
for n = 1:N
  % new U by explicit scheme
  if naive
    Unew = U;  % allocates by copying
    Unew(2:J) = U(2:J) + mu * (U(3:J+1) - 2 * U(2:J) + U(1:J-1));
    Unew(1) = Unew(2);    % naive way of enforcing Neumann
    Unew(J+1) = Unew(J);  % ditto
    U = Unew;
  else
    q = - k * (U(2:J) - U(1:J-1)) / dx;   % J-1 values
    q = [0, q, 0];                        % J+1 values, including b.c.s
    U = U - dt * (q(2:J+1) - q(1:J)) / dx;
  end
  % estimate energy
  if naive
    H(n+1) = 0.5 * dx * sum(U(1:J) + U(2:J+1));
  else
    H(n+1) = dx * sum(U);
  end
  % compute error
  c2 = exp(-  4 * pi^2 * k * t(n+1));
  c5 = exp(- 25 * pi^2 * k * t(n+1));
  uexact = c2 * cos(2 * pi * x) + c5 * cos(5 * pi * x);
  err(n+1) = max(abs(U - uexact));
end

figure
subplot(4,1,1:2)
plot(x,U,'ko-'),  xlabel('x'),  title('approx to u(x,t_f)'), grid on
subplot(4,1,3)
semilogy(t,err,'k'),  xlabel('t'),  ylabel('max |U - u|'),  grid on
subplot(4,1,4)
plot(t,H,'k'),  xlabel('t'),  ylabel('energy'),  grid on
