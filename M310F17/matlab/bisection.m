function [c, N] = bisection(f,a,b,tol)
% BISECTION  Apply the bisection method to solve  f(x) = 0  with initial
% bracket [a,b].  Computes number of steps N so that the result c is within
% tol>0 of the exact answer.
% Usage:
%   [c, N] = bisection(f,a,b,tol)
% Example:
%   >> f = @(x) x^3 - 2;
%   >> [c, N] = bisection(f,0,2,1e-6)

if f(a) * f(b) >= 0
  error('[a,b] must be a bracket, so that f(a), f(b) are of opposite sign')
end
N = ceil((log(b-a) - log(tol)) / log(2));  % from (3.2) in textbook
for k = 1:N
    c = (a+b)/2;
    r = f(c);
    if r == 0 
        return  % we are done
    elseif f(a) * r >= 0
        a = c;
    else
        b = c;
    end
end
