function [a,b,s] = ieeeparts(x);
% IEEEPARTS  Internally every floating point (double)
% number  x  has representation
%   x = (-1)^s (1.b1 b2 b3 ... b52)_2 x 2^{(e1 e2 ... e11)_2 - 1023)
%     = (-1)^s a 2^b
% This function returns these parts.  Thus
%   [a,b,s] = ieeeparts(x)
% has
%   x = any real number
%   s = 0 if x is positive, 1 if x is negative
%   a = real number in the interval  [1,2)
%   b = integer in the list  {-1022,...,1023}
% See also:  LOG2

if x < 0
  s = 1;
else
  s = 0;
end
% note: log2() is nearly the ieeeparts() function we want!
% but it has a different normalization, so we fix that
[f,e] = log2(abs(x));
a = 2 * f;
b = e - 1;

