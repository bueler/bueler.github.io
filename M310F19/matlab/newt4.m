% NEWT4  Compute P(x) using the Newton form, for 4 points.

n = 4;  x = [-1 0 3 5]';  y = [2 3 4 0]';  % the points

M = zeros(n,n);  % makes M the right size
% form M by columns
M(:,1) = ones(n,1);
for j=2:n
  M(j:n,j) = M(j:n,j-1) .* (x(j:n) - x(j-1));
end
b = y;

w = M \ b  % w has the coefficients of the polynomial:
% P(x) = w1 + w2 (x-x1) + w3 (x-x1) (x-x2) + w4 (x-x1) (x-x2) (x-x3)
