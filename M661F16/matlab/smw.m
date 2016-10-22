function Z = smw(Ainv,a,b)
% SMW  The Sherman-Morrison-Woodbury formula for the inverse of a rank-one
% perturbation of a matrix with known inverse:
%               A^-1 a b' A^-1
%   Z = A^-1 + ----------------
%               1 + b' A^-1 a
% giving the inverse of
%   A + a b'
%
% Example for testing correctness:
%   >> A = randn(4,4),  a = randn(4,1),  b = randn(4,1)
%   >> cond(A)                 % check A is invertible
%   >> Z1 = smw(inv(A),a,b)
%   >> Z2 = inv(A + a * b')
%   >> norm(Z1-Z2)

                            % FLOP counts: 
c = Ainv * a;               % 2 n^2 - n     (mat-vec)
d = b' * Ainv;              % 2 n^2 - n     (vec-mat ... same but gives row)
r = 1.0 / (1 + b' * c);     % 2 n + 1       (inner product plus two more)
Y = c * d;                  % n^2           (outer product)
Z = Ainv - r * Y;           % 2 n^2         (n^2 adds plus n^2 mults)

