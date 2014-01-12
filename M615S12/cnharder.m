function U = cnharder(U0,N,tf,fsource);
% CNHARDER   Solves the heat problem
%   u_t = (2 - x^2) u_xx + u + f(x,t),   u(0,t) = 0,  u(1,t) = 0
% using the given initial condition  u(x,0) = U0  and the given source
% function  f(x,t).  Applies the Crank-Nicolson method.  Returns
% computed U at final time tf.
% Example:
%   >> runharder(20)   % exact solution is NOT known
%   >> runmanu(20)     % exact solution IS known; returns maximum error

J = length(U0) - 1;       % extract spatial grid from U0
dx = 1.0 / J;  x = 0:dx:1;
dt = tf / N;
mu = dt / (2 * dx * dx);  % nonstandard mu

% build matrix A by rows using variable coefficients
c = 2 - x(2:J).^2;
A = sparse(J-1,J-1);
A(1,1:2) = [1 - 0.5 * dt + 2 * mu * c(1), - mu * c(1)];
for j=2:J-2
   A(j,j-1:j+1) = [- mu * c(j), 1 - 0.5 * dt + 2 * mu * c(j), - mu * c(j)];
end
A(J-1,J-2:J-1) = [-mu * c(J-1), 1 - 0.5 * dt + 2 * mu * c(J-1)];
% full(A)                 % uncomment to see A

U = U0;                   % set initial condition
U(1) = 0;  U(J+1) = 0;

% run
b = zeros(J-1,1);         % space for RHS of system for each time step
for n = 0:N-1
   t = (n + 1/2) * dt;    % midpoint of time step for accuracy
   for j = 1:J-1
      b(j) = mu * c(j) * U(j) + (1 + 0.5 * dt - 2 * mu * c(j)) * U(j+1) ...
               + mu * c(j) * U(j+2) + dt * fsource(x(j+1),t);
   end
   U(2:J) = (A \ b)';     % do time step
end

