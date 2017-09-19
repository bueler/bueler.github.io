function [t,Y] = eulermethod(f,t0,y0,n,h)
% EULERMETHOD  Use the Euler method to solve the ODE IVP
%   y' = f(t,y),  y(t0) = y0
% using n steps of size h.  Returns arrays of t-values and of y-values,
% both of length n+1, for easy plotting.
% Usage:
%   [t,Y] = eulermethod(f,t0,y0,n,h)
% Example:
%   [t,Y] = eulermethod(@(t,y) exp(t-y), 0, -1, 4, 0.25)

t = t0 : h : t0 + n * h;      % n+1 equally-spaced values
Y = zeros(1,n+1);             % set aside some space for the solution
Y(1) = y0;
for k = 1:n
    Y(k+1) = Y(k) + h * f(t(k),Y(k));   % the Euler step
end
