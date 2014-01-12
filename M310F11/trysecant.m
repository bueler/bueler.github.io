% TRYSECANT  show secant method and Newton's method.
% This implementation is careful enough to show why
% secant method is actually faster, *if you count function
% evaluations*.

format long
f = @(x) x - cos(x);

disp('secant:')
xold = 1;
x = 0.5;
fold = f(xold);
fcount = 1;  % just a counter for function evaluations
for n=1:10
  fcurr = f(x);
  fcount = fcount + 1;
  if abs(fcurr - fold) < 1e-15 
    break
  end
  xnew = x - fcurr * (x - xold) / (fcurr - fold);
  xold = x;
  fold = fcurr;
  if abs(x - xnew) < 1e-15, break, end
  x = xnew
end
fcount

disp('newton:')
df = @(x) 1 + sin(x);   % need this too!
x = 0.5;
fcount = 0;
for n=1:10
  xnew = x - f(x) / df(x);
  if abs(x - xnew) < 1e-15, break, end
  x = xnew
  fcount = fcount + 2;
end
fcount

