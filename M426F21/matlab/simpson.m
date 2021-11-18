function [S,t,y] = simpson(f,a,b,n)
%SIMPSON  Simpson's rule for numerical integration.
% Input:
%   f     integrand (function); must take vector inputs
%   a,b   interval of integration (scalars)
%   n     number of subintervals; MUST BE EVEN
% Output:
%   S     approximation to the integral of f over (a,b)
%   t     vector of nodes used
%   y     vector of function values at nodes
% Example:
%   >> [S,t,y] = simpson(@(x) x .* log(1+x),0,1,20);
%   >> S, plot(t,y)

if mod(n,2) ~= 0,  error('n must be even'),  end
h = (b-a)/n;
t = a + h*(0:n)';
y = f(t);
if n == 2
    S = (h/3) * ( y(1) + 4 * y(2) + y(3) );
else
    S = (h/3) * ( y(1) + 4 * sum(y(2:2:n)) + 2 * sum(y(3:2:n-1)) ...
                  + y(n+1) );
end