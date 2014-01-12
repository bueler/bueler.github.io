% SECANT0  Special code to do three steps of secant method for
%   x^3 - 2 = 0
% using inital guesses  x0 = 0  and  x1 = 1.

x0 = 0
x1 = 1
f = @(x) x^3 - 2;
for n=1:3
  xnew = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
  x0 = x1;
  x1 = xnew;
end
