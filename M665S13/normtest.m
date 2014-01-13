function  nA = normtest(A,p)
% NORMTEST computes induced matrix p-norm of A by monte carlo
% Example:  >> A = randn(3,3)
%           >> normtest(A,2)
%           >> norm(A,2)      % for comparison

maxiter = 50;
[m n] = size(A);

nA = 0.0;
for l = 1:maxiter
  x = randn(n,1);
  y = A * x;
  nA = max( nA, norm(y, p) / norm(x, p) )
  % or replace prev two lines with:
  %   x = x / norm(x,p);
  %   y = A * x;
  %   nA = max( nA, norm(y, p) )
  sleep(0.1)
end

