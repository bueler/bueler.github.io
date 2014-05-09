function [dx, maxerr] = leapfrog(JJ,tf)
% LEAPFROG  Apply the leap-frog finite difference scheme
%   U_j^{n+1} - U_j^{n-1}      U_{j+1}^n - U_{j-1}^n
%   --------------------- + a0 --------------------- = 0
%           2 dt                       2 dx
% to solve the advection equation initial/boundary value problem
%   u_t - 2 u_x = 0,   u(x,0) = sin(5 x) + 1,
% on -1 < x < 1, with boundary condition u(1,t) = 0.  Uses CFL to
% determine time step dt.  (Compare FTCS, an unstable scheme used on
% the same problem.)  Shows a figure with the final time solutions.
% Returns the maximum error at the final time.  Examples:
%   >> JJ = [25 50 100 200 400];
%   >> for j=1:5,  [dx(j), maxerr(j)] = leapfrog(JJ(j),0.99); end
%   >> loglog(dx,maxerr,'ko'),  grid on

a0 = -2;
g = @(x) sin(5*x) + 1;

dx = 2 / JJ;  x = -1:dx:1;             % JJ+1 points
dt = dx / abs(a0);                     % CFL:  |a0| dt / dx <= 1
NN = ceil(tf / dt);  dt = tf / NN;     % tf = NN * dt  exactly
nu = a0 * dt / dx

% use exact solution as initial condition (fair) and at t=dt (cheating!)
Uold = g(x);  U = zeros(size(Uold));
inside = (x < 1 + a0 * dt);  U(inside) = g(x(inside) - a0 * dt);

Unew = zeros(size(U));
for n = 2:NN
  Unew(2:JJ) = Uold(2:JJ) - nu * (U(3:JJ+1) - U(1:JJ-1));  % leapfrog
  Unew(1) = U(1) - nu * (U(2) - U(1)); % obligatory upwind at downstream bdry
  Unew(JJ+1) = 0;                      % upstream boundary condition
  Uold = U;
  U = Unew;
end
Uexact = zeros(size(U));
inside = (x < 1 + a0 * tf);  Uexact(inside) = g(x(inside) - a0 * tf);

plot(x,U,'ko',x,Uexact,'k--'),  legend('approx','exact'),  xlabel x,  ylabel u
maxerr = max(abs(U - Uexact));
