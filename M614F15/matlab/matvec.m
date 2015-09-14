function z = matvec(A,v)
% MATVEC  Computes  z = A * v.

[m n] = size(A);
if (size(v,1) ~= n)
  error('v must have length equal to number of cols in A')
end
if (size(v,2) ~= 1)
  error('v must be a column')
end

z = zeros(m,1);
for i = 1:m
  for j = 1:n
    z(i) = z(i) + A(i,j) * v(j);
  end
end
