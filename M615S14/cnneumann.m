function cnneumann(Z,color)
% CNNEUMANN  See problem 3 on Assignment #7.  Compares implementations of
%   (2.103),  (2.110),  (2.114)
% from Morton & Mayers, for left-end Neumann condition.  To generate a
% figure like 2.10, do
%   >> cnneumann(2103,'b'), hold on
%   >> cnneumann(2110,'r'), cnneumann(2114,'k'), hold off
%   >> grid on, xlabel('t_n'), ylabel('log_{10} E^n')

J = 10;
if Z==2103 | Z==2114
  dx = 1 / J;
elseif Z==2110
  dx = 1 / (J-0.5);
else
  error('input Z must be in {2103,2110,2114}')
end

tf = 1;
dt = 0.01;
N = 100;
mu = dt / dx^2;

A = sparse(J+1,J+1);
if Z==2103 | Z==2110
  A(1,1) = 1;
  A(1,2) = -1;
elseif Z==2114
  A(1,1) = 1+mu;
  A(1,2) = -mu;
end
A(J+1,J+1) = 1;
for j = 2:J
  A(j,j-1) = -0.5*mu;
  A(j,j)   = 1 + mu;
  A(j,j+1) = -0.5*mu;
end

if Z==2103 | Z==2114
  x = 0:dx:1;
elseif Z==2110
  x = -dx/2:dx:1;
end
t = 0:dt:tf;
err = zeros(size(t));

b = zeros(J+1,1);
U = cos(pi * x / 2)';
for n = 1:N
  b(2:J) = U(2:J) + 0.5 * mu * ( U(3:J+1) - 2 * U(2:J) + U(1:J-1) );
  if Z==2103 | Z==2110
    b(1) = 0;
  elseif Z==2114
    b(1) = (1-mu)*U(1) + mu*U(2);
  end
  b(J+1) = 0;
  U = A \ b;
  uexact = exp(-pi^2 * t(n+1) / 4) * cos(pi * x' / 2);
  err(n+1) = max(abs(U - uexact));
end

plot(t,log10(err),color)
