function [x fval lambda] = rsimpII(c, A, b, BB0)
% RSIMPII  Phase II of reduced simplex method.  Contains Procedure 13.1
% from Nocedal & Wright.

% input checking
c = c(:);  % force into columns
b = b(:);
n = length(c);
m = length(b);
if any(size(A) ~= [m n]),  error('A must be m by n'),  end
BB = BB0(:);
if length(BB) ~= m,  error('BB must contain m indices'),  end
if ~isindex(BB),  error('BB must be positive integers'), end
if any(BB > n),  error('indices in BB must be <= n'),  end
if cond(A(:,BB)) > 1.0e10,  warning('columns of A indicated by BB may not be linearly independent'),  end

x = zeros(n,1);
NN = setdiff((1:n)',BB)
for k = 1:2^n
	x(BB) = A(:,BB) \ b
	lam = A(:,BB)' \ c(BB)
	sN = c(NN) - A(:,NN)' * lam
    if all(sN >= 0)
        break
    end
    [discard, q] = min(sN);
    q
    d = A(:,BB) \ A(:,NN(q))
    [xqplus, p] = min(x(BB) ./ d)
    BB(p) = NN(q)
FIXME
	x(NN) = 0
    if k == 3, break, end
end

