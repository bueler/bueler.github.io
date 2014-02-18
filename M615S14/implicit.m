function U = implicit(J)
% IMPLICIT solves a standard heat problem
%   u_t = u_xx,   u(0,t) = u(1,t) = 0,   u(x,0) = sin(3 pi x)
% by implicit scheme.  Do
%   >> implicit(J);
% This code uses sparse storage and scales to high resolution,
% e.g. J = 10000.

dx = 1 / J;
tf = 0.1;      % final time
dt = tf / J;   % since scheme converges unconditionally, N = J is fine
mu = dt / dx^2;

% assemble matrix
A = sparse(J+1,J+1);
A(1,1) = 1;
A(J+1,J+1) = 1;
for j = 2:J
  A(j,j-1) = -mu;
  A(j,j)   = 1 + 2*mu;
  A(j,j+1) = -mu;
  % A(j,j-1:j+1) = [-mu, (1+2*mu), -mu];   % equivalent to previous 3 lines
end
% debug hint: for small J, look at A by either full(A) or spy(A)

% timestep to final time
x = 0:dx:1;
U = sin(3 * pi * x)';
for n = 1:J
  b = U;
  b(1) = 0;
  b(J+1) = 0;
  % to solve:  A U^{n+1} = b
  U = A \ b;
end
plot(x,U,'o-'),  xlabel('x'),  ylabel('approx to u(x,t_f)')
