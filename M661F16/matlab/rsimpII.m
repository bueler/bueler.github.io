function [x f lambda k] = rsimpII(c, A, b, BB, spew)
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
%     spew   = if true, print various intermediate quantities [default: false]

if nargin < 5,  spew = false;  end

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
NN = setdiff((1:n)',BB)';   % initial N indices are ordered

% repeat Procedure 13.1; there exist examples where 2^n steps needed
for k = 0:2^n
    if spew
        fprintf('  k = %d:\n',k)
        printints('[BB NN]',[BB NN])
    end
    % new primal (x) and dual (lambda) values
    x = zeros(n,1);
	x(BB) = A(:,BB) \ b;
    if spew,  printints('x''',x),  end
	lambda = A(:,BB)' \ c(BB);
    if spew,  printints('lambda''',lambda),  end
	% optimality test
	sN = c(NN) - A(:,NN)' * lambda;
    if spew,  printints('sN''',sN),  end
    if all(sN >= 0)
        break   % optimal point found
    end
    % entering variable;  NN(q) is entering index
    [~, q] = min(sN);
    if spew,  fprintf('    q = entering = %d\n',NN(q)),  end
    % the step
    d = A(:,BB) \ A(:,NN(q));
    if spew,  printints('d''',d),  end
    if all(d <= 0)
        x = inf(n,1);   % invalidate x (nonfeasible) because unbounded
        break
    end
    % the ratio test;  pindex is leaving index
    BDPOS = BB(d>0);
    if spew,  printints('ratios with d_i>0',x(BDPOS) ./ d(d>0)),  end
    [~, p] = min(x(BDPOS) ./ d(d>0));
    pindex = BDPOS(p);
    if spew,  fprintf('    p = leaving  = %d\n',pindex),  end
    % update the indices
    BB(BB == pindex) = NN(q);
    NN(q) = pindex;
end
f = c' * x;
end  % function


function printints(name, v)
    fprintf('    %s = [',name)
    for j = v,  fprintf(' %d',j), end
    fprintf(' ]\n')
end

function printreals(name, v)
    fprintf('    %s = [',name)
    for j = v,  fprintf(' %.4f',j), end
    fprintf(' ]\n')
end

