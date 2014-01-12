function z = trap(f,a,b,n)
% TRAP  Approximate integral
%    /b
%    |   f(x) dx
%    /a
% using composite trapezoid rule with n subintervals.
% The function f(x) must be vectorized (i.e. an input list x
% must be allowed).
%
% Example:  >> trap(@(x) exp(-x),0,2,32)
%           >> exact = 1-exp(-2)

h = (b-a)/n;
x = a:h:b;
z = (h/2) * [1 repmat([2],1,n-1) 1] * f(x)';
