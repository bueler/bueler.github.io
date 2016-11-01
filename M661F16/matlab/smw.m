function Z = smw(Ainv,a,b)
% SMW  The Sherman-Morrison-Woodbury formula for the inverse of a rank-one
% perturbation of a matrix, namely  A + a b',  where  A  is a matrix with
% a known inverse:
%                    A^-1 a b' A^-1
%        Z = A^-1 - ----------------
%                    1 + b' A^-1 a
%
% Example for testing correctness:
%   >> A = randn(4,4),  a = randn(4,1),  b = randn(4,1)
%   >> cond(A)                 % check A is invertible
%   >> Z1 = smw(inv(A),a,b)
%   >> Z2 = inv(A + a * b')
%   >> norm(Z1-Z2)             % is order 10^-15 or similar

                            % FLOP counts: 
a = Ainv * a;               % 2 n^2 - n     (mat-vec: n^2 mults, n^2-n adds)
b = b / (1 + b' * a);       % 3 n           (inner product, + 1, scale vector)
b = Ainv' * b;              % 2 n^2 - n     (mat-vec with transpose)
Z = a * b';                 % n^2           (outer product: n^2 mults)
Z = Ainv - Z;               % n^2           (n^2 adds)
