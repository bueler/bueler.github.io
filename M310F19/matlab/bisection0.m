function [a,b] = bisection0(a,b,n)
% BISECTION0 Solve
%   f(x) = 0
% using inital bracket [a,b] and doing n steps of bisection.
% The function is fixed:  f(x) = x^3-7x+2
% Example:
%   >> [a,b] = bisection0(0,1,50)
% Compare: BISECT

fa = a^3 - 7*a + 2;
fb = b^3 - 7*b + 2;
if fa == 0
  warning('f(a) identically zero');
  return
elseif fb == 0
  warning('f(b) identically zero');
  return
elseif fa * fb > 0
  error('[a,b] is not a bracket')
end

for i = 1:n
    c = (a+b)/2;
    fc = c^3-7*c+2;
    if fc == 0
        warning('midpoint is c ... f(c) identically zero');
        return
    end
    if fa*fc < 0
        b = c;
        fb = fc;
    else
        a = c;
        fa = fc;
    end
end

