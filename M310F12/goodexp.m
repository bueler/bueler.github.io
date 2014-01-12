function z = goodexp(x)
% GOODEXP  A Taylor series algorithm for computing exp(x) using only
% elementary operations.  Recall that
%   exp(x) = 1 + x + x^2/2 + x^3/3! + ...
% Computes exp(x) = 1 / exp(-x) if x < 0.  A pretty good algorithm:
% apparently stable but not as efficient as built-in exp().
% Example shows it gets the same answers:
%   >> format long
%   >> goodexp(10),  exp(10)    % good
%   >> goodexp(-20), exp(-20)   % good
% Timing comparison shows it is many times slower:
%   >> tic, for j=1:10000, goodexp(5); end, toc
%   >> tic, for j=1:10000, exp(5); end, toc
% Compare:  MYEXP.

if x < 0
  z = 1 / goodexp(-x);
  return
end

z = 1;
term = 1;
n = 0;
while abs(term) > 1.0e-15 * abs(z)
  n = n + 1;
  term = term * x / n;
  z = z + term;
end

