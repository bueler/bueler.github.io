function U = implicithog(J)
% IMPLICITHOG solves a standard heat problem
%   u_t = u_xx,   u(0,t) = u(1,t) = 0,   u(x,0) = sin(3 pi x)
% by implicit scheme, but VERY INEFFICIENTLY.  It hogs memory!  Do
%   >> implicithog(J);
% but don't try J=1000, which is easy for IMPLICIT.
% Note "BAD IDEA"s below.  Use IMPLICIT, which makes better choices!
% Compare:
%   >> tic, implicit(600); toc
%   Elapsed time is 0.058133 seconds.
%   >> tic, implicithog(600); toc
%   Elapsed time is 12.624 seconds.

dx = 1 / J;
tf = 0.1;       % final time
dt = tf / J;    % since scheme converges unconditionally, N = J is fine
mu = dt / dx^2;

A = zeros(J+1,J+1);    % BAD IDEA 1:  Fill memory with zeros.
A(1,1) = 1;
A(J+1,J+1) = 1;
for j = 2:J
  A(j,j-1) = -mu;
  A(j,j)   = 1 + 2*mu;
  A(j,j+1) = -mu;
end

x = 0:dx:1;
% BAD IDEA 2:  Fail to preallocate storage for U.  (Do "U = zeros(J+1,J+1);"
% here to fix this aspect.)
U(:,1) = sin(3 * pi * x)';
for n = 1:J
  b = U(:,n);
  b(1) = 0;
  b(J+1) = 0;
  % to solve:  A U^{n+1} = b
  U(:,n+1) = A \ b;    % BAD IDEA 3:  Store entire solution, instead of just
                       % the most recent values.  Of course it is o.k. to
                       % store the entire solution if that is really.
end
t = 0:dt:tf;
surf(x,t,U'),  xlabel('x'),  ylabel('t'),  zlabel('approx to u(x,t_f)')
