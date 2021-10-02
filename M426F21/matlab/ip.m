function z = ip(x,y)
% IP Compute the inner product of vectors x and y.

n = length(x);  % also check that n == length(y) ...
z = x(1) * y(1);
for j = 2:n
    z = z + x(j) * y(j);
end
