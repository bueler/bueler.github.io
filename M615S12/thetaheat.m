function U = thetaheat(U0,N,tf,theta);
% THETAHEAT   Solves the heat problem
%   u_t = u_xx,   u(0,t) = 0,  u(1,t) = 0
% using the given initial condition  u(x,0) = U0.  Returns computed U
% at final time tf.  This code does no plotting by itself.
% Example where exact solution is known:  RUNTHETA

if (theta < 0) | (theta > 1), error('theta must be between 0 and 1'), end

J = length(U0) - 1;       % extract spatial grid from U0
dx = 1.0 / J;
dt = tf / N;
mu = dt / (dx * dx)       % print mu
if (theta == 0) & (mu > 1/2), warning('run may be unstable'), end

% build matrix A by rows
c = theta * mu;
A = sparse(J-1,J-1);
A(1,1:2) = [1 + 2 * c, - c];
for j=2:J-2
   A(j,j-1:j+1) = [- c, 1 + 2 * c, - c];
end
A(J-1,J-2:J-1) = [- c, 1 + 2 * c];
% full(A)                 % uncomment to see A

U = U0;                   % set initial condition
U(1) = 0;  U(J+1) = 0;    % enforce initial boundary conditions

% run
b = zeros(J-1,1);         % space for RHS of system for each time step
cr = (1 - theta) * mu;    % constant on right side
for n = 0:N-1
   for j = 2:J
      b(j-1) = cr * U(j-1) + (1-2*cr) * U(j) + cr * U(j+1);
   end
   U(2:J) = (A \ b)';     % do time step by solving   A U = b
   U(1) = 0;  U(J+1) = 0;
end

