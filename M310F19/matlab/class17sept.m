% CLASS17SEPT  Demonstration of Newton's method and secant method
% as command-line operations using up-arrow and enter.

% define functions
f = @(x) cos(x) - x
df = @(x) -sin(x) - 1

% Newton's method
format long
x = 0.5
x = x - f(x)/df(x)
x = x - f(x)/df(x)
x = x - f(x)/df(x)
x = x - f(x)/df(x)
x = x - f(x)/df(x)

% repeated, but with evaluation of f(x) to see it goes to zero
x = 0.5
x = x - f(x)/df(x),  f(x)
x = x - f(x)/df(x),  f(x)
x = x - f(x)/df(x),  f(x)
x = x - f(x)/df(x),  f(x)

% secant method ... is almost as fast
xold = 0.5,  x = 0.6
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew
%xnew = x - f(x)*(x-xold)/(f(x)-f(xold));  xold=x,  x=xnew  % why commented-out?

