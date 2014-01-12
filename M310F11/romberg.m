function z = romberg(f,a,b)
% ROMBERG  Approximate integral
%    /b
%    |   f(x) dx
%    /a
% using Romberg integration with a fixed number of levels.
% Requires trap.m.  The function f(x) must be vectorized
% (i.e. an input list x must be allowed).
%
% This implementation is more understandable but less efficient
% than the pseudocode in section 5.8 of the text.
%
% Compare:  FASTROMBERG  (does same job, but a bit more efficiently)
% Requires: TRAP         (= trap.m)
%
% Example:  >> format long
%           >> trap(@(x) exp(-x),0,2,32)                       % compare
%           >> romberg(@(x) exp(-x),0,2)
%           >> exact = 1-exp(-2)
%           >> error = abs(romberg(@(x) exp(-x),0,2) - exact)  % = 10^-15

% get trapezoid results for 1 2 4 8 16 32 subintervals
N = 5;
m = 2.^(0:N);            % 6 levels of refinement
T = zeros(size(m));
for j=1:length(m)
  T(j) = trap(f,a,b,m(j));  % redundant function evaluations in here
end

% extrapolate to unreachable h=0 !!:
h = (b-a)./m;
p = polyfit(h.^2,T,N);   % extrapolate in h^2 versus T_n plane
z = p(end);              % evaluate constant term, the last poly coeff.

% uncomment to see the extrapolation
% hsqf = 0:((b-a)/1000)^2:(b-a)^2;  % fine grid of h^2
% plot(h.^2,T,'o',hsqf,polyval(polyfit(h.^2,T,N),hsqf)), xlabel('h^2'), ylabel('T(2^n)')

