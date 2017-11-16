function I = gauss4(f,a,b)
% GAUSS4  Use n=4 Gaussian quadrature (a.k.a. Gauss-Legendre quadrature) to
% to approximate
%     /b
%     |  f(x) dx
%     /a
% Uses change of variables to interval [-1,1], and stored nodes and weights for
% that interval.  Compare TRAP and SIMPOL.
% Example:
%    f = @(x) exp(-x);  exact = 1 - exp(-2)
%    gauss4(f,0,2)
%    error = abs(gauss4(f,0,2) - exact)

% nodes and weights for [-1,1]
x = [-0.8611363115940526, -0.3399810435848563, 0.3399810435848563, 0.8611363115940526];
w = [ 0.3478548451374476,  0.6521451548625464, 0.6521451548625464, 0.3478548451374476];

C = (b - a) / 2;    % constant from changing to [a,b]
I = 0;
for j = 1:4
    I = I + w(j) * f(a + C * (x(j) + 1));
end
I = C * I;

