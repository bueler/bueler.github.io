function Y = eulerP5(m)
% EULERP5  Solves ODE IVP on Assignment #1.  Does m steps.

f = @(t,Y) [Y(2);
            3*Y(1) - 2*Y(2)];
t0 = 2;  tf = 5;
Y0 = [0; -1];

h = (tf - t0) / m;
t = t0;
Y = Y0;
for k = 1:m
    Y = Y + h * f(t,Y);
    t = t + h;
end
