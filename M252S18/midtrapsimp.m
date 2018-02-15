% MIDTRAPSIMP  Compare n=4,10,40,200 results from midpoint, trapezoid, and
% Simpson's rule on integral where exact value is known exactly:
%    /9
%    |   x^2 exp(-x/2) dx = 10 sqrt(e) - 250 exp(-9/2)
%    /-1

f = @(x) x.^2 .* exp(-x/2);
exact = 10 * exp(1/2) - 250 * exp(-9/2);

% midpoint rule
Merr = [];
for n = [4 10 40 200]
    z = 0;
    dx = 10 / n;
    for i = 1:n
        xmid = -1 + (i-1/2) * dx;
        z = z + f(xmid);
    end
    M = dx * z;
    Merr = [Merr, abs(M - exact)];
end
Merr

% trapezoid rule
Terr = [];
for n = [4 10 40 200]
    z = f(-1) + f(9);
    dx = 10 / n;
    for i = 1:n-1
        x = -1 + i * dx;
        z = z + 2*f(x);
    end
    T = (dx/2) * z;
    Terr = [Terr, abs(T - exact)];
end
Terr

% Simpson's rule
Serr = [];
for n = [4 10 40 200]
    dx = 10 / n;
    z = f(-1) + 4 * f(-1+dx) + f(9);
    for i = 2:2:n-1
        x1 = -1 + i * dx;
        x2 = x1 + dx;
        z = z + 2 * f(x1) + 4 * f(x2);
    end
    S = (dx/3) * z;
    Serr = [Serr, abs(S - exact)];
end
Serr

% built-in QUAD
Qerr = abs(quad(f,-1,9) - exact)    % only evaluated f(x) 21 times

