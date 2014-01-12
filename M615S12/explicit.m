function U = explicit(J,N,tf)
% EXPLICIT  Solve the heat equation model problem using
% explicit scheme.  Second draft, has some vectorized code.
% Good-looking examples:
%   >> explicit(10,10,0.1);
%   >> explicit(20,100,0.1);
%   >> explicit(24,100,0.1);
%   >> explicit(40,400,0.1);
% Bad-looking examples:
%   >> explicit(25,100,0.1);
%   >> explicit(100,100,0.1);
%   >> explicit(20,50,0.1);
%   >> explicit(10,10,1.0);
% We must understand:
%   (1) if the good-looking examples are really good
%   (2) what is going on in the bad examples, and how to avoid it

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
end

mesh(x,t,U)
xlabel x, ylabel t, zlabel U

