function p = horner(x,c)
% HORNER evaluates a polynomial at a point x, given
% a list of its coefficients c:
%   p(x) = c(1) + c(2) x + c(3) x^2 + ... + c(n+1) x^n
% for example, if x = 2 and c = [1 2 5]
% then p(x) = 1 + 2 * 2 + 5 * 2^2 = 25 so
%   >> horner(x,c)
%   ans = 25

n = length(c) - 1;
p = c(n+1);
for k = n:-1:1
  p = c(k) + x * p;
end

