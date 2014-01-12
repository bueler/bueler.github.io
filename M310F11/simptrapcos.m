% SIMPTRAPCOS  Example of 10 digit accuracy for integral
%    /10
%    |   cos(x) dx  =  sin(10)
%    /0
% using n = 1536 subintervals for Simpson's rule and n = 912870
% for trapezoid rule.

format long
exact = sin(10)

% Simpson's first
n = 1536;  h = (10-0)/n;  x = 0:h:10;
cS = [1 repmat([4 2],1,(n-2)/2) 4 1];  % = [1 4 2 4 2 4 2 ... 4 1]
% ways to check these are right coeffs:
%length(cS),  cS(1:8),  cS(end-8:end)
simps = (h/3) * cS * cos(x)'

% Trapezoid requires about 600 times more function evals
n = 912870;  h = (10-0)/n;  x = 0:h:10;
cT = [1 repmat([2],1,n-1) 1];  % = [1 2 2 2 2 ... 2 1]
trape = (h/2) * cT * cos(x)'

