function [Tx, Tfcount, clabels, rlabels] = allsolve(tol)
% ALLSOLVE  Solve three different problems by three different methods.
% The command
%   [Tx Tfcount clabels rlabels] = allsolve(tol)
% produces a table of 9 results 'Tx', a table 'Tfcount' with 9 function counts,
% a list of 3 column labels 'clabels', and a list of 3 row labels 'rlabels'.

format long
Tx = zeros(3,3);  Tfcount = zeros(3,3);
clabels = ['(a) f(x) = x^3-2   ';
           '(b) f(x) = x-e^{-x}';
           '(c) f(x) = 5-x^{-1}'];
rlabels = ['bisection';
           'Newton   ';
           'secant   '];

for part = 1:3
  % the three parts have different f and inital bracket  [and Newton needs df]
  if part == 1      % (a)
    f = @(x) x.^3 - 2;     df = @(x) 3 * x.^2;
    a0 = 1;    b0 = 2;   % CORRECTION!:  x0 = 0 was bad start for Newton!
  elseif part == 2  % (b)
    f = @(x) x - exp(-x);  df = @(x) 1 + exp(-x);
    a0 = 0;    b0 = 1;
  elseif part == 3  % (c)
    f = @(x) 5 - x.^(-1);  df = @(x) x.^(-2);
    a0 = 0.1;  b0 = 0.25;
  end

  % bisection
  a = a0;  b = b0;
  fa = f(a);  fb = f(b);  fcount = 2;
  for n = 1:100  % should never reach it ...
    c = (a+b) / 2;
    fc = f(c);  fcount = fcount + 1;
    if fa * fc < 0
      b = c;  fb = fc;  % update b
    elseif fb * fc < 0
      a = c;  fa = fc;  % update a
    else
      break  % c is the answer because f(c) = 0
    end
    if abs(b-a) < tol
      break
    end
  end
  Tx(1,part) = c;  Tfcount(1,part) = fcount;

  % Newton
  x = a0;  % as directed
  fcount = 0;
  for n = 1:20  % should never reach it
    xnew = x - f(x) / df(x);  fcount = fcount + 2;
    if abs(xnew - x) < tol   % known to be a good stopping criterion
      break
    end
    x = xnew;
  end
  Tx(2,part) = xnew;  Tfcount(2,part) = fcount;

  % secant
  x0 = a0;  x1 = b0;  % as directed
  f0 = f(x0);  fcount = 1;
  for n = 1:20  % should never reach it
    f1 = f(x1);  fcount = fcount + 1;
    xnew = x1 - f1 * (x1 - x0) / (f1 - f0);
    if abs(xnew - x1) < tol
      break
    end
    x0 = x1;  f0 = f1;
    x1 = xnew;
  end
  Tx(3,part) = xnew;  Tfcount(3,part) = fcount;
end % for
