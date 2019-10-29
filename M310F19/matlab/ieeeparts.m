function [v,k,s] = ieeeparts(x);
% IEEEPARTS  Every floating point (double) number x has internal
% representation
%   x = (-1)^s (1.b1 b2 b3 ... b52)_2 x 2^{(e1 e2 ... e11)_2 - 1023)
%     = (-1)^s v x 2^k
% This function returns these parts.  Thus for any real number x
%   [v,k,s] = ieeeparts(x)
% satisfies
%   v = real number in the interval  [1,2)
%   k = integer in the list  {-1022,...,1023}
%   s = 1 if x is negative and 0 otherwise
% See also:  LOG2

if x < 0
  s = 1;
else
  s = 0;
end
% note: log2() is nearly the ieeeparts() function we want!
% but it has a different normalization, so we fix that
[f,e] = log2(abs(x));
v = 2 * f;
k = e - 1;

