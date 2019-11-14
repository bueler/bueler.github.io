function I = clenshawcurtis(f,n)
% CLENSHAWCURTIS  Compute n+1 point Clenshaw-Curtis quadrature
% on the fixed interval [-1,1].  From  Trefethen, L. N. (2008),
% "Is Gauss quadrature better than Clenshaw–Curtis?", SIAM Review
% 50 (1), 67–87.  Example:
%   >> I = clenshawcurtis(@cos,11)
%   >> abs(I - 2*sin(1))

x = cos(pi*(0:n)'/n);                     % Chebyshev points
fx = f(x)/(2*n);
g = real(fft(fx([1:n+1 n:-1:2])));        % Fast Fourier Transform
a = [g(1); g(2:n)+g(2*n:-1:n+2); g(n+1)]; % Chebyshev coefficients
w = 0*a'; w(1:2:end) = 2./(1-(0:2:n).^2); % weight vector
I = w*a;                                  % the integral
