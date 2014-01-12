function z = mysqrt(x)
% MYSQRT  Computes the square root z of a positive or zero input x:
%    z = mysqrt(x)
%
% Conceptually, this code exploits the internal floating point
% representation of the number x.  The exponent of the result is
% computed by integer operations.  It then uses Newton's method
% to get many accurate digits fast.  (Some operations below have
% very fast implementations as bit operations, especially "b/2"
% when b is even, "(b-1)/2" when b is odd, and "2^(integer)" which
% is really just setting the bits in the exponent.)
%
% Example: random comparisons to built-in:
%   >> format long
%   >> mysqrt(19), sqrt(19)
%   >> mysqrt(pi*1e23),  sqrt(pi*1e23)
%   >> mysqrt(0.00009876),  sqrt(0.00009876)
% See also: IEEEPARTS, SQRT

if x < 0, error('MYSQRT only works for x >= 0'), end
if x == 0
  z = 0;
  return;
end

[a,b] = ieeeparts(x);   % so  x = a 2^b

z = 1 + (a - 1) / 2;    % this is fast by bit operations!
                        % if "z=1.5" here then need 5 iterations
                        % in the next line to get all 16 digits right
for k = 1:4
  z = 0.5 * (z + a / z);
end

if mod(b,2) == 0
  z = z * 2^(b/2);
else
  z = 1.41421356237310 * z * 2^((b-1)/2);
end

