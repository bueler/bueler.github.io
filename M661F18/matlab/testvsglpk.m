function testvsglpk(n,m)
% TESTVSGLPK  This test program for TWOPHASE versus GLPK in Octave.
% (This code does not run in Matlab.)
% Generates a random feasible n variable, m constraint standard form problem
%   min   z = c' * x
%   s.t.  A x = b
%         x >= 0
% Often the generated problem is unbounded; the two codes should agree in 
% that case also.

% defaults to interesting cases n=10,m=5 where unbounded occurs decent fraction
% of time
if nargin < 1,  n = 10;  end
if nargin < 2,  m = 5;  end

% set-up problem, making sure of feasibility and b >= 0
xf = n * rand(n,1);   % a feasible point; xf >= 0; NOT optimal
c = randn(n,1);
A = randn(m,n);
b = A * xf;
A = diag(sign(b)) * A;
b = abs(b);

% run GLPK from Octave  (GLPK is from GNU)
lb = zeros(size(xf));       % lower bounds:  x >= 0
ub = [];                    % no upper bounds
ctype = repmat('S',1,m);    % constraints are equalities
vartype = repmat('C',1,n);  % variables are continuous
s = +1;                     % minimize
param.msglev = 1;
param.itlim = 100;
[xmin, fmin, status, extra] = glpk(c, A, b, lb, ub, ctype, vartype, s, param);

% run our own code
[x,z] = twophase(c,A,b);

% compare
if status > 0
    fprintf('GLPK reports failed solve ... does TWOPHASE report unbounded?\n\n')
else
    fprintf('DIFFERENCES |GLPK-TWOPHASE|:  |x-x*| = %.2e,  |z-z*| = %.2e\n\n',...
            norm(xmin-x),abs(fmin-z))
end
