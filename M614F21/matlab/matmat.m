function C = matmat(A,B)
% MATMAT  Computes  C = A * B.

[m n] = size(A);
if (size(B,1) ~= n)
    error('number of rows of B must equal number of columns of A')
end
k = size(B,2);

C = zeros(m,k);
for i = 1:m
    for j = 1:k
        C(i,j) = A(i,1) * B(1,j);
        for s = 2:n
            C(i,j) = C(i,j) + A(i,s) * B(s,j);
        end
    end
end
