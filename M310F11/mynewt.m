function z = mynewt(f,df,x0,tol)
% MYNEWT  Use Newton's method to solve  f(x) = 0,  given a function
% f,  its derivative  df,  an initial guess  x0,  and an error
% tolerance  tol.   Example:  To solve  sin(x) = 0  using initial
% guess  x0 = 3  to get 12 digits of accuracy:
%   >> f = @(x) sin(x);  df = @(x) cos(x)
%   >> mynewt(f,df,3,1e-12)

x = x0;
for n=1:20
  xnew = x - f(x) / df(x);
  if abs(xnew - x) < tol   % known to be good stopping criterion
    break
  end
  x = xnew;
end
if n<20, fprintf('  [did n = %d steps for error < %.2e]\n',n,tol)
else, warning('MYNEWT did 20 iterations; answer may be inaccurate'), end
z = xnew;
