function z = fastsqrt(a)
% FASTSQRT  Use Newton's method, and a floating point representation, and
% linear interpolation, to get fast, accurate square roots using only
% +, -, *, /.
% Examples:
%   >> format long
%   >> sqrt(17), fastsqrt(17)
%   >> x = 3.4789234789e50;  sqrt(x), fastsqrt(x)

if a < 0, error('FASTSQRT(x) only works for x >= 0'), end

if a == 0, z = 0; return, end    % done with x = 0 case

% extract mantissa and exponent in base 2 scientific notation;
%   (in a real implementation this would be *done instantly by hardware*)
[b,p] = log2(a);                 % mantissa  b  is in [1/2,1]
if mod(p,2)==1                   % is exponent  p  odd?
  p = p + 1;                     %   make it even:  p = 2k
  b = b / 2;                     %   value  b * 2^p  unchanged
end                              % now 1/4 <= b <= 1

x = (2*b + 1) / 3;               % initial guess  x_0  from linear interpolation
for n=1:4
  x = 0.5 * (x + b / x);         % Newton's method on  f(x) = x^2 - b = 0
end
z = x * 2^(p/2);                 % = sqrt(b) * 2^k

