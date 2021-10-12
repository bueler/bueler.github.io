% KEPLER  Fit some planetary data using a power law  tau = c R^alpha.
% See Exercise 3.1.6 in Driscoll & Braun.  Recall we fit after taking
% logs, i.e.  log(tau) = alpha log(R) + log(c) = z(1) log(R) + z(2)
% so  z(1) = alpha  and  z(2) = log(c).

R =   [   57.59,   108.11,   149.57,  227.84,  778.14,  1427, ...
        2870.3,   4499.9,   5909];
tau = [   87.99,   224.7,    365.26,  686.98, 4332.4,  10759, ...
       30684,    60188,    90710];

% note polyfit produces coefficients in reverse order so z(1) is
%   the coefficient of log(R) here
z = polyfit(log(R),log(tau),1);   % linear fit for log-log data
alpha = z(1)
c = exp(z(2))
