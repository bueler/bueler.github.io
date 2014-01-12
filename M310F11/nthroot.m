function z = nthroot(x,n)
% NTHROOT  Use Newton's method to solve compute  x^(1/n),  the
% nth root of x, for integer n:  n = 1,2,3,4,...
% Uses only -,*,/, and no built-in power function.  Calls helper
% code NTHPOW.  Examples show agreement with built-in power:
%   >> format long
%   >> nthroot(5,2),  sqrt(5)
%   >> nthroot(1000,7),  1000^(1/7)
%   >> nthroot(0.00001,13),  0.00001^(1/13)

if floor(n) ~= n, error('only works with integer n'), end
if n < 1, error('n >= 1 is required'), end

tol = 1e-14;
zold = 1;              % a very simple formula for initial guess!
for j = 1:200
  z = zold - (nthpow(zold,n) - x) / (n * nthpow(zold,n-1));
  if abs(z - zold) < tol,  break,  end
  zold = z;
end
fprintf('  [did n = %d steps for error < %.2e]\n',j,tol)
