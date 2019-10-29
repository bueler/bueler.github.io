function z = mysqrt(x)
% MYSQRT  Computes the square root z of a positive (or zero) x:
%    z = mysqrt(x)
%
% This code exploits the internal floating point representation
% of the number x.  The exponent of z is computed by integer
% operations.  It then uses Newton's method to get accurate digits
% fast.  Note that some operations have very fast implementations
% as bit operations, namely multiplying and dividing by two.
%
% Example comparisons to built-in:
%   >> format long
%   >> mysqrt(19), sqrt(19)
%   >> mysqrt(pi*1e23),  sqrt(pi*1e23)
%   >> mysqrt(0.00009876),  sqrt(0.00009876)
% Example; shows relative error is O(eps) versus built-in:
%   format short g
%   for k=1:20
%       x = exp(20*randn(1));
%       err = abs(mysqrt(x)-sqrt(x)) / sqrt(x);
%       disp([x err])
%   end
% Requires: IEEEPARTS
% See also: SQRT, MYSQRTTAY

if x < 0
    error('MYSQRT only works for x >= 0')
end
if x == 0
    z = 0;
    return
end

% write  x = v 2^k  with  1 <= v < 2  and  k an integer
[v,k] = ieeeparts(x);

% compute sqrt(v) by Newton's method
z = 1.2;                % middle of interval [1,sqrt(2)]
for j = 1:4             % testing suggests need 4 iterations
  z = 0.5 * (z + v / z);
end

% get correct exponent in base 2 floating point
if mod(k,2) == 0        % is k even?
  z = z * 2^(k/2);
else
  z = 1.4142135623730950 * z * 2^((k-1)/2);  % use precomputed sqrt(2)
end

