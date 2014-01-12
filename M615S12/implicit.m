function U = implicit(J,N,tf);
% IMPLICIT  Implicit method for heat equation problem
%    u_t = u_xx,   u(0,t) = 0, u(1,t) = 0,   u(x,0) = sin(2 pi x)
% by implicit method.  Uses a sparse matrix A.
% Example with mu = 2:
%   >> implicit(20,20,0.1);
%   >> explicit(20,20,0.1);  % for comparison

dt = tf / N;
dx = 1.0 / J;
mu = dt / dx^2;
x = 0:dx:1;
t = 0:dt:tf;

% assemble matrix row by row; see equation (2.64) in Morton & Mayers
A = sparse(J-1,J-1);    % tell Matlab what kind of matrix we will build
A(1,[1, 2]) = [(1+2*mu), -mu];
for j = 2:J-2
  A(j,[j-1, j, j+1]) = [-mu, (1+2*mu), -mu];
end
A(J-1,[J-2, J-1]) = [-mu, (1+2*mu)];
% to look at matrix:   full(A), spy(A)

% numerically-approximate PDE
U = zeros(N+1,J+1);     % allocate space
U(1,:) = sin(2*pi*x);   % set initial condition; implicitly a for loop
for n = 1:N
  b = U(n,2:J)';        % right side of system from U at t_n
  v = A \ b;            % solve system
  U(n+1,2:J) = v';      % update U at t_{n+1}
  U(n+1,1) = 0;         % set boundary conditions
  U(n+1,J+1) = 0;
end

% show solution
mesh(x,t,U)
xlabel x, ylabel t, zlabel U

