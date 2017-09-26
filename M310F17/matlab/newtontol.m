function [x, N] = newtontol(f,df,x0,tol)
% NEWTONTOL  Use Newton's method to (attempt to) solve f(x)=0 from initial
% iterate x0.  Stops when successive iterates are within a small multiple
% of the tolerance; see theory supporting this idea in section 3.3.  Optionally
% the number of steps N taken.
% Caution:  This code has no protection against infinite loops!
% Usage:
%   [x, N] = newtontol(f,df,x0,tol)
% Example:
%   >> f = @(x) 5 - 1/x;  df = @(x) 1/x^2;
%   >> [x,N] = newtontol(f,df,0.25,1.0e-6)
%   x =  0.20000
%   N =  5

xold = x0;
x = xold - f(xold) / df(xold);
N = 1;
while 5 * abs(x - xold) > tol
    xold = x;
    x = xold - f(xold) / df(xold);
    N = N + 1;
end
