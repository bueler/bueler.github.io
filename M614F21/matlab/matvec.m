function z = matvec(A,v)
% MATVEC  Computes  z = A * v.

if (size(v,2) ~= 1)
    error('v must be a column')
end
[m n] = size(A);
if (length(v) ~= n)
    error('length(v) must equal columns in A')
end

z = zeros(m,1);
for i = 1:m
    for j = 1:n
        z(i) = z(i) + A(i,j) * v(j);
    end
end
