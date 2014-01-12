function z = fastromberg(f,a,b,n)
% BUELERROMBERG  Approximate integral
%    /b
%    |   f(x) dx
%    /a
% using Romberg integration.  Computes successive trapezoid approximations
% efficiently, by reusing function evaluations.  Extrapolates by Neville's
% method, which avoids computing polynomial coefficients at all.
%
% Usage:
%    >> fastromberg(f,a,b,n)
% where [a,b] is the integral of integration and f = f(x) is a vectorized
% function (i.e. an input list x must be allowed).  Input n is the number
% of levels of refinement: evaluates f(x) at total of  2^(n-1) + 1  times.
%
% Compare:  ROMBERG,  TRAP
%
% Example:  >> format long
%           >> fastromberg(@(x) exp(-x),0,2,6)
%           >> exact = 1 - exp(-2)
%           >> trap(@(x) exp(-x),0,2,32)    % trap. rule using same finest grid

if n < 1, error('n must be 1,2,3,...'), end

h = b - a;                              % initial h
R = zeros(n,n);                         % space for whole Neville table
R(1,1) = 0.5 * h * (feval(f,a) + feval(f,b));  % n = 1 version of trapezoid
L = 1;                                  % L = 2^{i-2}
for i=2:n
  s = 0.0;
  for k = 1:L
    s = s + feval(f,a + (k-0.5)*h);
  end
  R(i,1) = 0.5 * (R(i-1,1) + h * s);    % n = 2^{i-1} case of trapezoid
  for j=2:i
    c = 1.0 / (4^(j-1) - 1);
    R(i,j) = R(i,j-1) + c * ( R(i,j-1) - R(i-1,j-1) ); % extrapolation step
  end
  h = h / 2;                            % h value for next iteration
  L = L * 2;                            % L value for next iteration
end
z = R(n,n);
% R                                     % uncomment to see whole table R_{k,j}

