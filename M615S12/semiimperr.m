function err = semiimperr(J,N,tf);
% SEMIIMPERR  Same as SEMIIMP but modified to produce only the error
% as output.

dt = tf / N;    t = 0:dt:tf;
dx = pi / J;    x = 0:dx:pi;
mu = dt / dx^2;

% assemble matrix row by row; same matrix as in implicit.m
A = sparse(J-1,J-1);    % tell Matlab what kind of matrix we will build
A(1,[1, 2]) = [(1+2*mu), -mu];
for j = 2:J-2
  A(j,[j-1, j, j+1]) = [-mu, (1+2*mu), -mu];
end
A(J-1,[J-2, J-1]) = [-mu, (1+2*mu)];

% numerically-approximate PDE
U = zeros(N+1,J+1);           % allocate space
U(1,:) = sin(x) + sin(3*x);   % set initial condition
Uexact = U;
for n = 1:N
  b = (1 + dt) * U(n,2:J)';   % right side of system
  v = A \ b;                  % solve system
  U(n+1,2:J) = v';            % update U at t_{n+1}
  U(n+1,1) = 0;               % set boundary conditions
  U(n+1,J+1) = 0;
  Uexact(n+1,:) = sin(x) + exp(-8 * n * dt) * sin(3*x);
end

err = max(max(abs(U - Uexact)));

