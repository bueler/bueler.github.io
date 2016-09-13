% CALCONE_BRUTE  Find min of calculus I function by brute force: generate
% millions of values and select smallest.

f = @(x) (x.^2 + cos(x)).^2 - 10.0 * sin(5.0 * x);

N = 2*10^6 + 1;
x = linspace(0.0,2.0,N);

[y, ix] = min(f(x))     % min is an allowed "black box" because its
                        % implementation is obvious
x(ix)
