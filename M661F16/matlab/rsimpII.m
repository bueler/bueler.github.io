function [x fval lambda] = rsimpII(c, A, b, BB0)
% RSIMPII  Phase II of reduced simplex method.  Contains Procedure 13.1
% from Nocedal & Wright.

% input checking: vectors
c = c(:);  % force into columns
b = b(:);
n = length(c);
m = length(b);
if any(size(A) ~= [m n]),  error('A must be m by n'),  end

% input checking: indices
BB = BB0(:);
if length(BB) ~= m,  error('BB must contain m indices'),  end
if ~isindex(BB),  error('BB must be positive integers'), end
if any(BB > n),  error('indices in BB must be <= n'),  end
if cond(A(:,BB)) > 1.0e10,  warning('columns of A indicated by BB may not be linearly independent'),  end
NN = setdiff((1:n)',BB);   % initial N indices are ordered

% repeat Procedure 13.1; there exist examples where 2^n steps needed
for k = 1:2^n
    % new primal (x) and dual (lambda) values
    x = zeros(n,1);
	x(BB) = A(:,BB) \ b;
	lambda = A(:,BB)' \ c(BB);
	% optimality test
	sN = c(NN) - A(:,NN)' * lambda;
    if all(sN >= 0)
        break   % optimal point found
    end
    % entering variable;  NN(q) is entering index
    [~, q] = min(sN);
    % the step
    d = A(:,BB) \ A(:,NN(q));
    if all(d <= 0)
        error('problem is unbounded')
    end
    % the ratio test;  pindex is leaving index
    BDPOS = BB(d>0);
    [~, p] = min(x(BDPOS) ./ d(d>0));
    pindex = BDPOS(p);
    % update the indices
    BB(BB == pindex) = NN(q);
    NN(q) = pindex;
end
fval = c' * x;

