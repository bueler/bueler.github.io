function [ztrap zsimp] = trapsimp(n)
% TRAPSIMP  Compute both the composite trapezoid and Simpson's
% rule approximations of the integral
%    /1
%    |  cos(x^2) dx
%    /0
% using n applications of the rule.  Example:
%   >> format long g
%   >> [ztrap zsimp] = trapsimp(10)

h = 1 / n;

xtrap = 0 : h : 1;
ftrap = cos(xtrap.^2);
ctrap = [1 2*ones(1,n-1) 1];          % coeffs for trapezoid rule
ztrap = (h/2) * sum(ctrap .* ftrap);

xsimp = 0 : h/2 : 1;                  % meaning of h changes slightly
fsimp = cos(xsimp.^2);
csimp = [1 repmat([4 2],1,n-1) 4 1];  % coeffs for Simpson's rule
zsimp = (h/6) * sum(csimp .* fsimp);
