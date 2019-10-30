function z = mysqrttay(x)
% MYSQRTTAY  Computes the square root z of a positive (or zero) x:
%    z = mysqrttay(x)
% by exploiting the floating-point form of x = v 2^k.  The exponent
% of z is computed by integer operations.  In contrast to MYSQRT,
% *which is BETTER*, this code uses a high-degree Taylor polynomial to
% compute the root of v.  Some operations have fast implementations
% as bit operations, namely multiplying and dividing by two.
% Example comparisons to built-in:
%   >> format long
%   >> mysqrttay(19), sqrt(19)
%   >> mysqrttay(pi*1e23),  sqrt(pi*1e23)
%   >> mysqrttay(0.00009876),  sqrt(0.00009876)
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
    error('MYSQRTTAY only works for x >= 0')
end
if x == 0
    z = 0;
    return
end

% write  x = v 2^k  with  1 <= v < 2  and  k an integer
[v,k] = ieeeparts(x);

% by division and pre-computed stored numbers, shift
% v into interval [1,17/16]
C = 1;
if v >= 1.5                     % = 3/2
    C = C * 1.2247448713915889; % = C * sqrt(3/2)
    v = v / 1.5;
end
if v >= 1.25                    % = 5/4
    C = C * 1.1180339887498949; % = C * sqrt(5/4)
    v = v / 1.25;
end 
if v >= 1.125                   % = 9/8
    C = C * 1.0606601717798212; % = C * sqrt(9/8)
    v = v / 1.125;
end 
if v >= 1.0625                  % = 17/16
    C = C * 1.0307764064044151; % = C * sqrt(17/16)
    v = v / 1.0625;
end 

% for  1 <= v < 1.0625, compute sqrt(v) by degree 8
% Taylor polynomial at basepoint a=1
u = v - 1;
z = 1 + u/2 - u^2/8 + u^3/16 - 5*u^4/128 + 7*u^5/256 - ...
    21*u^6/1024 + 33*u^7/2048 - 13*33*u^8/32768;
z = C * z;

% get correct exponent in base 2 floating point
if mod(k,2) == 0        % is k even?
  z = z * 2^(k/2);
else
  z = 1.4142135623730950 * z * 2^((k-1)/2);  % use precomputed sqrt(2)
end

