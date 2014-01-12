function U = semiimp(J,N,tf,noplot);
% SEMIIMP  Semi-implicit method for heat-equation-with-reaction problem
%    u_t = u_xx + u,   u(0,t) = 0, u(pi,t) = 0
% and initial condition   u(x,0) = sin(x) + sin(3 x), as on Assignment 4.
% Exact solution included.  See also IMPLICIT.   Example:
%   >> semiimp(100,50,0.5);

if nargin<4, noplot=0; end
dt = tf / N;
dx = pi / J;
mu = dt / dx^2;
x = 0:dx:pi;
t = 0:dt:tf;

% assemble matrix row by row; see equation (2.64) in Morton & Mayers;
% same matrix as in implicit.m
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
  t_now = n * dt;
  Uexact(n+1,:) = sin(x) + exp(-8 * t_now) * sin(3*x);
end

err = max(max(abs(U - Uexact)));
fprintf('max error is %.3e\n',err)

% show solution
if noplot>0, return, end
figure(1),  clf
subplot(2,1,1),  mesh(x,t,U),  xlabel x,  ylabel t,  zlabel U
title('numerical solution')
subplot(2,1,2),  mesh(x,t,Uexact),  xlabel x,  ylabel t,  zlabel U
title('exact solution')

