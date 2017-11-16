function z = romberg(f,a,b,K)
% ROMBERG  Approximates the integral    /b
%                                       |   f(x) dx
%                                       /a
% by K-level Romberg integration.  Includes the trapezoid rule internally.
% The input function f(x) must be vectorized.  This implementation is more
% understandable, but less efficient than, the pseudocode in section 5.8 of
% the text.  Compare OPTBERG, which does same job, but more efficiently.
% Example:  compare TRAPOL and GAUSS4 to ROMBERG
%     f = @(x) exp(-x);      exact = 1-exp(-2)
%     T = trapol(f,0,2,32),  errT = abs(T - exact)
%     G = gauss4(f,0,2),     errG = abs(G - exact)
%     R = romberg(f,0,2,5),  errR = abs(R - exact)

n = 2.^(1:K);                         % = [2 4 8 16 ... 2^K]
h = (b-a) ./ n;
T = zeros(size(n));
for j = 1:K
    x = a:h(j):b;                     % nodes of trapezoid rule
    c = [0.5, ones(1,n(j)-1), 0.5];   % coefficients of trap. rule
    T(j) = h(j) * sum(c .* f(x));     % not opt.: redundant fcn. evaluations
end
% extrapolate to unreachable h=0
p = polyfit(h.^2,T,K-1);              % not optimized: excess arithmetic
z = p(end);                           % gets constant term in polynomial

