function [x f lambda k] = rsimpII(c, A, b, BB, spew)
% RSIMPII  Phase II of reduced simplex method.  Implements Procedure 13.1
% from Nocedal & Wright.  Requires linear program in standard form, namely
%     min c'*x   subject to   A x = b,  x >= 0
% Requires initial "basis" BB, an index set on columns of A.
%
% Usage:
%     [x f lambda k] = rsimpII(c, A, b, BB, spew)
% where
%     x      = solution;  = inf if no solution from unbounded feasible set
%     f      = objective value c'*x at solution
%     lambda = lagrange multipliers (dual variables) at solution
%     k      = number of steps (moves of basic feasible point)
%     c      = column vector of length n
%     A      = m by n matrix
%     b      = column vector of length m
%     BB     = initial basis indices; must be subset of {1,...,n} with
%              with size m and so that corresponding columns of A are
%              linearly-independent:  B = A(:,BB) is invertible
%     spew   = if true, print intermediate quantities [default: false]
%
% Example:  gives feedback; see TESTRSIMP for additional examples
%   c = [-4 -2 0 0]';
%   A = [1   1 1 0;
%        2 0.5 0 1];
%   b = [5 8]';
%   BB = [3 4];
%   [x, f, lambda, k] = rsimpII(c, A, b, BB, true)
%   [xgl, fgl] = glpk(c, A, b)     % compare to black box *available in Octave*
%
% See also:  TESTRSIMP, GLPK

if nargin < 5,  spew = false;  end

% input checking: vectors
c = c(:);  b = b(:);  % force into columns
n = length(c);
m = length(b);
if any(size(A) ~= [m n]),  error('A must be m by n'),  end

% input checking: indices
BB = BB(:)';  % force into row
if length(BB) ~= m,  error('BB must contain m indices'),  end
if ~isindex(BB),  error('BB must be positive integers'), end
if any(BB > n),  error('indices in BB must be <= n'),  end

% initial N indices are ordered complement of BB
NN = setdiff((1:n)',BB)';

% iterate Procedure 13.1; there exist examples where 2^n steps needed
for k = 0:2^n
    % new primal (x) and dual (lambda) values
    if rcond(A(:,BB)) < 1.0e-10
        warning('columns A(:,BB) may not be linearly-independent')
    end
    x = zeros(n,1);
	x(BB) = A(:,BB) \ b;
	lambda = A(:,BB)' \ c(BB);
	% optimality test
	sN = c(NN) - A(:,NN)' * lambda;
    if spew
        fprintf('  k = %d:\n',k)
        printv('x''',x)
        printv('[BB NN]',[BB NN],true)
        printv('lambda''',lambda)
        printv('sN''',sN)
    end
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
    % ratio test;  pindex is leaving index
    BDPOS = BB(d>0);
    [~, p] = min(x(BDPOS) ./ d(d>0));
    pindex = BDPOS(p);
    if spew
        fprintf('    q = entering = %d\n',NN(q))
        printv('d''',d)
        printv('ratios with d_i>0',x(BDPOS) ./ d(d>0))
        fprintf('    p = leaving  = %d\n',pindex)
    end
    % update the indices
    BB(BB == pindex) = NN(q);
    NN(q) = pindex;
end
f = c' * x;
end  % function


function printv(name, v, integer)
    if nargin < 3,  integer = false;  end
    fprintf('    %s = [',name)
    for j = v
        if integer,  fprintf(' %d',j)
        else,  fprintf(' %.4f',j),  end
    end
    fprintf(' ]\n')
end

