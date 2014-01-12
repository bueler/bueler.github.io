% CHECKHQ  check that the n=2 case of Gauss-Hermite quadrature is exact
% as expected on f(x) = x^0, x^1, x^2, x^3 in the integrals
%      / +inf
%      |      f(x) exp(-x^2) dx
%      / -inf

[X W] = hermquad(2);
x = X';  w = W';
exact = [sqrt(pi) 0 sqrt(pi)/2 0];
for p = 0:3
  s(p+1) = sum(w .* (x.^p));
end
norm(s - exact)
