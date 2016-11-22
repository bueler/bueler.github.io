function [x f lambda k] = rsimpII(c, A, b, BB)
% RSIMPII  Phase II of reduced simplex method.  Contains Procedure 13.1
% from Nocedal & Wright.  Requires linear program in standard form
%     min c'*x   subject to   A x = b,  x >= 0
% and (phase II) the initial basis BB as an index set on columns of A.
%
% Usage:
%     [x f lambda k] = rsimpII(c, A, b, BB)
% where
%     x      = solution; will be infinite (nonfeasible) if no solution
%              because feasible set is unbounded
%     f      = value c'*x at solution
%     lambda = lagrange multipliers (dual variables) at solution
%     c      = column vector of length n
%     A      = m by n matrix
%     b      = column vector of length m
%     BB     = initial basis indices; must be subset of {1,...,n} with
%              with size m and so that corresponding columns of A are
%              linearly-independent:  B = A(:,BB) is invertible

% input checking: vectors
c = c(:);  b = b(:);  % force into columns
n = length(c);
m = length(b);
if any(size(A) ~= [m n]),  error('A must be m by n'),  end

% input checking: indices
BB = BB(:)';  % force row
if length(BB) ~= m,  error('BB must contain m indices'),  end
if ~isindex(BB),  error('BB must be positive integers'), end
if any(BB > n),  error('indices in BB must be <= n'),  end
if cond(A(:,BB)) > 1.0e10
    warning('columns of A indicated by BB may not be linearly independent')
end
NN = setdiff((1:n)',BB);   % initial N indices are ordered

% repeat Procedure 13.1; there exist examples where 2^n steps needed
for k = 0:2^n
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
        x = inf(n,1);   % invalidate x (nonfeasible) because unbounded
        break
    end
    % the ratio test;  pindex is leaving index
    BDPOS = BB(d>0);
    [~, p] = min(x(BDPOS) ./ d(d>0));
    pindex = BDPOS(p);
    % update the indices
    BB(BB == pindex) = NN(q);
    NN(q) = pindex;
end
f = c' * x;

