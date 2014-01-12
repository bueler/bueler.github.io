function explodes = explicitcheck(J,N,tf)
% EXPLICITCHECK  Check if explicit scheme explodes; returns 1 if so and
% zero otherwise.  Example:
%   >> boom
% (which calls EXPLICITCHECK).  See also  EXPLICIT.

dt = tf / N;   % equivalently: tf = N dt
dx = 1.0 / J;
mu = dt / dx^2;
x = 0:dx:1;
t = 0:dt:tf;

% n = 1,...,N+1  and n=1 is initial condition
% j = 1,...,J+1  and
%      j=1 is left boundary x=0, j=J+1 is right boundary x=1
U = zeros(N+1,J+1); % allocate space

U(1,:) = sin(2*pi*x);  % set initial condition; implicitly a for loop

% numerically-approximate PDE
for n = 1:N
  for j = 2:J
    U(n+1,j) = U(n,j) + mu * (U(n,j+1) - 2 * U(n,j) + U(n,j-1));
  end
  if (max(abs(U(n+1,:))) > 10.0)
    explodes = 1;
    return
  end
end
explodes = 0;

