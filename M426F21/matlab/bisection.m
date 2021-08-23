function r = bisection(f,a,b)
% BISECTION  Apply the bisection method to solve f(x) = 0
% on an interval [a,b].
% Example (problem I in notes):
%   >> f = @(x) exp(x) - sqrt(4 - x.^2)
%   >> r1 = bisection(f,0,1)
%   >> r2 = bisection(f,-2,-1)
%   >> f(r1), f(r2)

if f(a) * f(b) > 0
    error('initial interval is not a bracket!')
end
for k = 1:52   % a good gimmick; why 52?
    r = (a + b) / 2;
    if f(a) * f(r) >= 0.0 
      a = r;
    else
      b = r;
    end
end
