function [a,b] = bisection(f,a,b,tol)
% BISECTION Solve
%   f(x) = 0
% using inital bracket [a,b] and reducing the bracket
% until b-a < tol.
% Example:
%   >> f = @(x) x.^3 - 7*x + 2;
%   >> [a,b] = bisection(f,0,1,1.0e-10)
% Compare: BISECT, BISECTION0

fa = f(a);
fb = f(b);
if fa == 0
  warning('f(a) identically zero');
  return
elseif fb == 0
  warning('f(b) identically zero');
  return
elseif fa * fb > 0
  error('[a,b] is not a bracket')
end
if b - a < tol
  error('b-a negative or tol already satisfied')
end
if tol <= 0
  error('tol>0 is required')
end

n = ceil(log2((b-a) / tol));

for i = 1:n
    c = (a+b)/2;
    fc = f(c);
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

