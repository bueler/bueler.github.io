function z = trap(f,a,b,n)
% TRAP  Implement Algorithm 2.5 from Epperson 2nd ed, the composite
% trapezoid rule.  Evaluates f(x) only once per node x_i.
% Example:
%   f = @(x) x .* exp(-x);
%   trap(f,-1,3,100)
%   exact = -4 * exp(-3)
%   abs(trap(f,-1,3,100) - exact)

h = (b - a) / n;
s = 0.5 * (f(a) + f(b));
for i = 1:n-1
    x = a + i * h;
    s = s + f(x);
end
z = h * s;

