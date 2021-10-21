function y = lambertWnewt(x)
% LAMBERTWNEWT  For input x, solve the equation  x = y exp(y),
% giving y = W(x), called the Lambert W function.  Solves the
% equation by Newton's method.  Works on any nonnegative real
% input x, either a scalar or a 1D array.
% Example:
%   >> lambertWnewt(1)
% Note lambertw() is a Matlab built-in, so one can compare:
%   >> abs(lambertw(1) - lambertWnewt(1))
% Compare lambertW which uses fzero.

% Implementation:
% See  https://en.wikipedia.org/wiki/Lambert_W_function
% for more information on the Lambert W function.  Based on
% the asymptotic expansion W_0(x) at that page, we use initial
% iterate x/2 for x < 2 and log(x) - log(log(x)) for x >= 2.
% Then Newton's method is applied with 5 fixed steps.

if (any(not(isreal(x))) || any(x < 0))
     error('x must be real and nonnegative')
end
% we solve  g(y) = x(j) - y * exp(y) = 0
dg = @(y) - (1 + y) * exp(y);   % g'(y) does not depend on x
y = zeros(size(x));
for j = 1:length(x)
    if x(j) < 2
        z = x(j) / 2;
    else
        z = log(x(j)) - log(log(x(j)));
    end
    for k = 1:5
        z = z - (x(j) - z * exp(z)) / dg(z);
    end
    y(j) = z;
end
