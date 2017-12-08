function x = backsub(A,b)
% BACKSUB  Back-substitution, as in Algorithm 7.1 in Epperson 2nd ed.
% Input system  A x = b  must have a square, nonsingular, upper-triangular
% matrix A.  See GAUSSELIM.  Do
%   >> help gausselim
% for an example.

[n,z] = size(A);
if n ~= z,  error('matrix A must be square'),  end
M = tril(A,-1);
if norm(M) > 0,  error('matrix A must be upper triangular'),  end
if any(diag(A) == 0.0),  error('diagonal of A must be nonzero'),  end
[p,q] = size(b);
if (p ~= n) | (q ~= 1),  error('vector b must be n-length column'),  end

x = zeros(n,1);
x(n) = b(n) / A(n,n);
for i = n-1:-1:1
    x(i) = (b(i) - A(i,i+1:n) * x(i+1:n)) / A(i,i);
end

