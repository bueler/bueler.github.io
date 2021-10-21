function y = lambertW(x)
% LAMBERTW  For input x, solve the equation  x = y exp(y).
% This gives y = W(x), called the Lambert W function.  We use an
% initial guess x/2 and call FZERO to solve the equation.
% Gives acceptable accuracy on 0 <= x <= 4.
% Example:
%   >> lambertW(1)
% Note lambertw() is a Matlab built-in.

g = @(y) x - y * exp(y);
y = fzero(g, x / 2);
