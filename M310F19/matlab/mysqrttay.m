function z = mysqrttay(x)
FIXME
% MYSQRT  Computes the square root z of a positive (or zero) x:
%    z = mysqrttay(x)
%
% This code exploits the internal floating point representation
% of the number x.  The exponent of z is computed by integer
% operations.  In contrast to MYSQRT, which is faster, this code
% uses a high-degree Taylor polynomial.  Note that some operations
% have very fast implementations as bit operations, namely
% multiplying and dividing by two.
%
% Example comparisons to built-in:
%   >> format long
%   >> mysqrttay(19), sqrt(19)
%   >> mysqrttay(pi*1e23),  sqrttay(pi*1e23)
%   >> mysqrttay(0.00009876),  sqrttay(0.00009876)
% Example; shows relative error is O(eps) versus built-in:
%   format short g
%   for k=1:20
%       x = exp(20*randn(1));
%       err = abs(mysqrttay(x)-sqrt(x)) / sqrt(x);
%       disp([x err])
%   end
% Requires: IEEEPARTS
% See also: SQRT, MYSQRT

if x < 0
    error('MYSQRT only works for x >= 0')
end
if x == 0
    z = 0;
    return
end

% write  x = v 2^k  with  1 <= v < 2  and  k an integer
[v,k] = ieeeparts(x);

C = 1;
if v >= 1.5
    C = C * sqrt(1.5);
    v = v / 1.5;
end
if v >= 1.25
    C = C * sqrt(1.25);
    v = v / 1.25;
end 
if v >= 1.125
    C = C * sqrt(1.125);
    v = v / 1.125;
end 
if v >= 1.0625
    C = C * sqrt(1.0625);
    v = v / 1.0625;
end 

% now  1 <= v < 1.125 so compute sqrt(v) by degree ??
% Taylor polynomial at basepoint a=1
u = v - 1;
z = 1 + u/2 - u^2/8 + u^3/16 - 5*u^4/128 + 7*u^5/256;
%z = sqrt(v);  %FIXME
z = C * z;

% get correct exponent in base 2 floating point
if mod(k,2) == 0        % is k even?
  z = z * 2^(k/2);
else
  z = 1.4142135623730950 * z * 2^((k-1)/2);  % use precomputed sqrt(2)
end

