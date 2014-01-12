function U = explicitONE(J,N,tf)
% EXPLICITONE  Solve the heat equation model problem using
% explicit scheme, a first draft.
% Example we intend:
%   >> explicitONE(10,10,0.1)
% See also EXPLICIT.

% tf = N dt
dt = tf / N;
dx = 1.0 / J;
mu = dt / dx^2;

% n = 1,...,N+1  and n=1 is initial condition
% j = 1,...,J+1  and j=1 is left side and j=J+1 is right side

U = zeros(N+1,J+1);

% set initial condition
for j = 1:J+1
  U(1,j) = sin(2 * pi * (j-1) * dx);
end

% numerically-approximate PDE
for n = 1:N
  for j = 2:J
    U(n+1,j) = U(n,j) + mu * (U(n,j+1) - 2 * U(n,j) + U(n,j-1));
  end
end

mesh(U)
xlabel x, ylabel t, zlabel U

