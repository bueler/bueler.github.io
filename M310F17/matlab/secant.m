function [x, n] = secant(f,x0,x1,tol)
% SECANT  Use the secant method to (attempt to) solve f(x)=0 from initial
% iterates x0 and x1.  Stops when |f(x)| is less than tolerance or when
% consecutive iterates are equal.
% Usage:
%   [x, n] = secant(f,x0,x1,tol)
% Example:
%   >> f = @(x) x - cos(x);
%   >> x = secant(f,0.0,0.5,1e-6)
%   x =  0.73909

if x0 == x1
    error('secant method must start with distinct x0, x1 ... stopping')
elseif abs(f(x0)) < tol
    x = x0;
    return
elseif abs(f(x1)) < tol
    x = x1;
    return
end
for n = 1:20   % take at most 20 steps
    if x0 == x1
        x = x1;
        return
    end
    m = (f(x1) - f(x0)) / (x1 - x0);
    if m == 0
        error('computed slope equal to zero ... stopping')
    end
    x = x1 - f(x1) / m;
    if abs(f(x)) < tol
        return
    end
    x0 = x1;
    x1 = x;
end
warning('maximum number of steps taken ... result may be inaccurate')

