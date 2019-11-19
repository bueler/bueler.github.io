function z = myromberg(f,a,b,lev)
% MYROMBERG  Implementation of Romberg integration.  The idea is to do
% extrapolation to h=0 (Richardson extrapolation) of the results of
% applying the trapezoid rule T_h for various stepsizes h.  Calls MYTRAP
% to do the trapezoid rule.  This is NOT an efficient implementation
% because it recomputes f(x) values unnecessarily and because it uses
% POLYFIT (thus Vandermonde matrices) to fit the (h^2,T_h) data.
% Example:
%   >> f = @(x) exp(-x.^2);
%   >> myromberg(f,0,2,6)   % 6 levels:  T_2, T_1, T_0.5, ..., T_0.03125
%   >> mytrap(f,0,2,64)     % last T_h used has n=2^6=64
%   >> quad(f,0,2)          % essentially exact

n = 2 .^ (1:lev);                % use trapezoid rule for these n
h = (b-a) ./ n;                  % corresponding step sizes
for k = 1:lev
    T(k) = mytrap(f,a,b,n(k));   % get each T_h
end
p = polyfit(h.^2,T,lev-1);       % polynomial fit in (h^2,T_h) plane
z = p(lev);                      % z = p(h=0)  is last coeff. of p

