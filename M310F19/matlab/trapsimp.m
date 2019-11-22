function [ztrap zsimp] = trapsimp(n)
% TRAPSIMP  Compute both the composite trapezoid and Simpson's
% rule approximations of the integral
%    /1
%    |  cos(x^2) dx
%    /0
% using n+1 points.  Example:
%   >> format long g
%   >> [zt zs] = trapsimp(10)
%   >> quad(@(x) cos(x.^2),0,1)        % exact value

if mod(n,2) ~= 0,  error('n must be even'),  end
h = (1 - 0) / n;
x = 0 : h : 1;
y = cos(x.^2);

ctrap = [1 2*ones(1,n-1) 1];              % coeffs for trapezoid rule
ztrap = (h/2) * sum(ctrap .* y);

csimp = [1 repmat([4 2],1,(n/2)-1) 4 1];  % coeffs for Simpson's rule
zsimp = (h/3) * sum(csimp .* y);
