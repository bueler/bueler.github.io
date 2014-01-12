function [ztrap zsimp] = trapsimp(n)
% TRAPSIMP  Compute both the composite trapezoid and Simpson's
% rule approximations of this integral -->     /1
% using n subintervals.  For example:          |  cos(x^2) dx
% >> [ztrap zsimp] = trapsimp(10)              /0

h = 1 / n;
x = 0 : h : 1;
ftrap = cos(x.^2);
ctrap = [1 2*ones(1,n-1) 1];  % coeffs for trapezoid rule
ztrap = (h/2) * (ctrap * ftrap');

xsimp = 0 : h/2 : 1;
fsimp = cos(xsimp.^2);
csimp = [1 repmat([4 2],1,n-1) 4 1];  % coeffs for Simpson's rule
zsimp = (h/6) * (csimp * fsimp');
