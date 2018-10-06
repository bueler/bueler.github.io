function Z = mynull(A)
% MYNULL Constructs a null space matrix for m x n matrix A, with full row rank,
% using the QR decomposition.

[m n] = size(A);
if m > n,  error('A must be  m x n  with m <= n'),  end
[Q R] = qr(A');
if abs(R(m,m)) < 1.0e-12 * norm(R(:),'inf')
    warning('small R(m,m) value suggests A is rank deficient')
end
Z = Q(:,m+1:n);

