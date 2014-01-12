% CLASS3DEC  in-class session showing the effectiveness
% of 3 point Gaussian quadrature relative to Simpson's rule

% coefficients and nodes (interpolation points) for Gaussian
% quadrature; see "Gaussian quadrature" wikipedia page
format long g
A = [5 8 5]/9
x = [-sqrt(3/5) 0 sqrt(3/5)]

% think of the quadrature rule as a dot product
f = @(x) x.^2;
A * f(x)'

% recalling that the integral of x^(2k) on [-1,1] is
% 2/(2k+1) while the integral of x^(2k+1) on [-1,1] is zero,
% we check powers 0,1,2,3,4,5:
A * [1 1 1]'
A * x'
A * (x.^2)'
A * (x.^2)'
A * (x.^3)'
A * (x.^4)'
A * (x.^5)'
A * (x.^6)'   % here the Gauss rule fails; should be 2/7 = 0.28571

% now try Simpson's rule
As = (2/6)*[1 4 1]
xs = [-1 0 1]
As * [1 1 1]'
As * xs'
As * (xs.^2)'
As * (xs.^3)'
As * (xs.^4)'  % here Simpson's rule fails; should be 2/5 = 0.40

% finally try an integral which is not a polynomial; let's assume
% the quad() result is exact:
g = @(x) cos(x.^2).^2;
A * g(x)'     % Gaussian
As * g(xs)'   % Simpson's
quad(g,-1,1)  % exact

