% FROZENPIPE  Solve exercise 6, section 3.3 of Epperson 2nd edition.
% The problem is not solvable without a value for T0 or equivalent extra
% information, so we set T0 = 10 deg Celsius.  It follows that T = -30 deg C.
% Using  u(x,t)=0  and simplifying this
%      0  -  10         /      x      \
%    ------------ = erf |-------------|
%     10 - (-30)        \ 2 sqrt(a t) /
% generates f(x) = 0.  Uses the built-in ERF function, and the known
% derivative of ERF.  Calls NEWTONTOL to run Newton's method.

a = 1.25e-6;      % units:  ft^2/sec
t = 30*24*60*60;  % 30 days as seconds

CC = 2 * sqrt(a * t);
f = @(x) 3/4 - erf(x / CC);
% see page 96 for formula for erf() that allows us to find its derivative
GG = 1 / sqrt(pi * a * t);
df = @(x) - GG * exp(- x^2 / CC^2);

x0 = 0.0;  % an initial guess ... when you have no idea how deep to bury it
[x,N] = newtontol(f,df,x0,1.0e-4)
