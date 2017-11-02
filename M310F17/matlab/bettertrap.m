function z = bettertrap(f,df,a,b,n)
% BETTERTRAP  Compute the "corrected trapezoid rule" T_n^C(f) shown
% on page 267 of Epperson.  Compare TRAP.
% Example:
%   f = @(x) x .* exp(-x);
%   df = @(x) (1 - x) .* exp(-x);
%   exact = -4 * exp(-3)
%   abs(trap(f,-1,3,100) - exact)
%   abs(bettertrap(f,df,-1,3,100) - exact)

h = (b - a) / n;
z = trap(f,a,b,n);
z = z - (h^2 / 12) * (df(b) - df(a));

