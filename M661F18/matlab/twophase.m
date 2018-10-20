function [x,z] = twophase(c,A,b,showiters,maxiters)
% TWOPHASE  Solve linear programming problem in standard form using
% two-phase simplex method:
%   minimize    z = c'*x
%   subject to  A*x = b
%               x >= 0
% where c is length n, A is m x n, and b >= 0 is length m.  Applies two-phase
% strategy to find initial basic feasible solution.
% See Griva, Nash, Sofer (2009) sections 5.2 and 5.4 for algorithm.
% WARNING:  This code has no protection against cycling or degenerate vertices.
% Usage:  [x, z] = twophase(c,A,b)
%         [x, z] = twophase(c,A,b,true)    % show iterations
%         [x, z] = twophase(c,A,b,?,K)     % maximum of K iterations
% For testing see TESTVSGLPK.  Compare MYSIMPLEX which works for Ax<=b form.

% set optional arguments to defaults
if nargin < 4,  showiters = false;  end
if nargin < 5,  maxiters = 100;  end

% get sizes and check inputs
[m n] = size(A);
b = b(:);   c = c(:);                % force into columns
if length(b) ~= m,  error('A and b do not have compatible sizes'),  end
if any(b < 0),  error('b >= 0 required'),  end
if length(c) ~= n,  error('A and c do not have compatible sizes'),  end

% phase 1: solve an l.p. problem to get basic feasible solution for
% original problem
cP1 = [zeros(n,1); ones(m,1)];
AP1 = [A eye(m,m)];
xP1 = [zeros(n,1); b];
[xa,zP1] = simplexphase(n+m,m,cP1,AP1,b,xP1,showiters,maxiters);
if any(xa) < 0.0,  error('simplexphase() produced nonfeasible'),  end
if zP1 > 1.0e-14,  error('problem may be unfeasible'),  end
x0 = xa(1:n);
fprintf('PHASE ONE completed; initial basic feasible solution is:\n')
xsf = sprintf('  x = %s\n',repmat(' %g ',1,length(x0)));
fprintf(xsf,x0)

% phase 2: solve original problem using just-computed b.f.s.
[x,z] = simplexphase(n,m,c,A,b,x0,showiters,maxiters);
fprintf('PHASE TWO completed\n')
end % function twophase

    function [x,z] = simplexphase(n,m,c,A,b,x0,showiters,maxiters)
    % SIMPLEXPHASE  Solve standard form linear programming problem using
    % basic feasible solution x.
    
    if any(x0 < 0),  error('x is not feasible (! x>=0)'),  end
    if norm(A*x0-b)/max(1,norm(x0)) > 1.0e-14,  error('x is not feasible (! Ax=b)'),  end
    Bset = 1:n;
    Bset = Bset(x0 > 0);      % only use of x0: choose basic variables
    Nset = setdiff(1:n,Bset);
    % main loop: move from one basic feasible solution to the next
    for k = 1:maxiters
        % get current basis variables (hatb) and reduced costs (hatcN)
        cB = c(Bset);
        cN = c(Nset);
        B = A(:,Bset);
        N = A(:,Nset);
        hatb = B \ b;
        y = B' \ cB;
        hatcN = cN - N' * y;
        % optionally print a lot of stuff
        if showiters
            fprintf('iteration %d:\n',k)
            Bsf = sprintf('  Bset = %s\n',repmat(' %d ',1,length(Bset)));
            fprintf(Bsf,Bset)
            Nsf = sprintf('  Nset = %s\n',repmat(' %d ',1,length(Nset)));
            fprintf(Nsf,Nset)
            hatcNsf = sprintf('  ^cN = %s\n',repmat(' %g ',1,length(hatcN)));
            fprintf(hatcNsf,hatcN)
            [x,z] = getcurrent(c,hatb,Bset);
            xsf = sprintf('  x = %s\n',repmat(' %g ',1,length(x)));
            fprintf(xsf,x)
            fprintf('  z = %g\n',z)
        end
        % test optimality
        if all(hatcN >= 0)
            fprintf('ending: optimum found on iteration %d\n',k)
            break
        end
        % get entering index (t)
        [ww, t] = min(hatcN);   % ww not used
        % check for unbounded problem
        hatAt = B \ A(:,Nset(t));
        if showiters
            hatAtsf = sprintf('  ^At = %s\n',repmat(' %g ',1,length(hatAt)));
            fprintf(hatAtsf,hatAt)
        end
        if all(hatAt <= 0)
            fprintf('ending: detected unbounded on iteration %d\n',k)
            break
        end
        % use ratio test to get leaving index (s)
        hatAt(hatAt <= 0) = -1;
        ratios = hatb ./ hatAt;
        ratios(ratios < 0) = Inf;
        [ww, s] = min(ratios);
        % update index sets
        tmp = Bset(s);
        Bset(s) = Nset(t);
        Nset(t) = tmp;
        Nset = setdiff(1:n,Bset);   % Nset ends up sorted
    end
    if k >= maxiters,  warning('maximum number of iterations reached'),  end
    [x,z] = getcurrent(c,hatb,Bset);
    end % function simplexphase

    function [x, z] = getcurrent(c,hatb,Bset)
    % GETCURRENT  Uses Bset and hatb to build current x.  Uses c to get z.
    x = zeros(size(c));
    x(Bset) = hatb;
    z = c' * x;
    end % function getcurrent

