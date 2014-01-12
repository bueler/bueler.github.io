function z = deg4int(f,a,b)
% DEG4INT Approximates the integral of f(t) on [a,b] using a degree 4
% polynomial interpolant.
% Example: >> deg4int(@(x) sin(x),0,pi)   % exact = 2.0000000

dt = (b-a)/4;
t = (a:dt:b)';
%dt = (b-a)/6;  t = (a:dt:b)';  t = t(2:6);   % <-- alternative
y = f(t);
A = [ones(5,1) t t.^2 t.^3 t.^4];
c = A \ y;
v1 = a.^(1:5);
v2 = b.^(1:5);
z = ((v2 - v1) ./ (1:5)) * c;

