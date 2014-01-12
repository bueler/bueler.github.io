function z = nthpow(x,n)
% NTHPOW  For integer  n >= 1,  compute x^n  using multiplication.
% Example:
%   >> nthpow(5,3),  5^3

if floor(n) ~= n, error('only works with integer n'), end
if n < 1, error('n >= 1 is required'), end

z = x;
for j = 1:n-1
  z = z * x;
end
