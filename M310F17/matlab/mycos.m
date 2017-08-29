function z = mycos(x)
% MYCOS Compute cos(x) using only arithmetic and a stored value of pi.
% Accurate to more than 5 digits.  Imperfections: only works for scalar x
% and uses Taylor polynomials (vs e.g. better polynomials or rational functions).
% Compare built-in COS.
% Example:
%   >> mycos(1), mycos(-pi^2), mycos(10^6)
%   >> cos(1), cos(-pi^2), cos(10^6)
% See MYCOSTEST for example of randomized test.

pi = 3.14159265358979324;     % actually: this is built-in and not needed

% use properties of cos(x) to put close to 0
x = mod(x, 2*pi);             % now  0 <= x < 2 pi
if x > pi
   x = 2*pi - x;
end                           % now  0 <= x <= pi
if x > pi/2
   s = -1;
   x = pi - x;
else
   s = 1;
end                           % now  0 <= x <= pi/2  and  s = sign(cos(x))

% Taylor's theorem (section 1.1) for cos(x) at x=0,
%   p_10(x) = 1 - x^2/2 + x^4/4! - ... - x^10/10!,
% which we evaluate using Horner's method (section 2.1)
xx = x^2;
p = - 1/720 + xx * (1/40320 - xx/3628800);
p = 1 + xx * (- 1/2 + xx * (1/24 + xx * p));
z = s * p;

