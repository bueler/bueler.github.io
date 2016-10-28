function [x, xlist] = lcg(x0,A,b,...
                          atol,maxiter)
% LCG  The linear conjugate gradient method.  This is Algorithm 5.2 in
% Nocedal & Wright.  Will generally only succeed if  A  is a symmetric
% positive definite (SPD) matrix with cond(A) of modest size.  This code is
% suitable for approximate solution to large SPD systems if tolerance (atol)
% is set appropriately, as otherwise n steps are done if  A  is  n x n.
%
% Usage:
%   [x, xlist] = lcg(x0,A,b,atol,maxiter)
% where
%   x     = final result; approximate solution to Ax=b; length n column vector
%   xlist = OPTIONAL: list of all iterates
%   x0    = user-provided initial iterate; set to zero if unknown
%   A     = n x n symmetric positive-definite matrix
%   b     = length n column vector for right-hand side of system Ax=b
%   atol  = OPTIONAL: absolute tolerance; terminates if ||r_k|| < atol;
%           defaults to 0 so runs maxiter steps
%   maxiter = OPTIONAL: maximum number of iterations; defaults to n
%
% Fixed size Example:
%   >> A = randn(4,4);  A = A' * A + eye(4,4);               % A is SPD
%   >> b = randn(4,1);  x0 = zeros(4,1);
%   >> x = lcg(x0,A,b);
%   >> norm(A * x - b)
%   >> x2 = A \ b;  norm(x - x2)
%
% Bigish Example:
%   >> N = 1000;  A = randn(N,N);  A = A '* A + eye(N,N);    % A is SPD
%   >> xstar = randn(N,1);  b = A * xstar;  x0 = zeros(N,1);
%   >> [x, xlist] = lcg(x0,A,b,1.0e-6);
%   >> size(xlist,2)                % number of iterates
%   >> norm(A*x - b) / norm(b)      % properly-scaled size of residual
%   >> norm(x - xstar)              % absolute size of error
% The result in this example is o.k. ... but preconditioning is needed to
% significantly reduce the number of iterates.

% do checks
n = size(A,1);
if size(A,2) ~= n,  error('A must be square'),  end
b = b(:);        % force into column
if length(b) ~= n,  error('b must be  n x 1  if A is  n x n'),  end
if nargin < 4,  atol = 0.0;  end
if nargin < 5,  maxiter = n;  end
x0 = x0(:);
if nargout > 1,  xlist = [x0];  end

% run CG
x = x0;
r = A * x - b;
rsqr = r' * r;
p = - r;
for k = 1:maxiter
    Ap = A * p;                                % only mat-vec is here
    alpha = rsqr / (p' * Ap);
    x = x + alpha * p;
    if nargout > 1,  xlist = [xlist x];  end   % optional: append x to list
    r = r + alpha * Ap;                        % faster than: r = A * x - b
    rsqrnew = r' * r;
    if sqrt(rsqrnew) < atol                    % same as ||grad f(xk)|| < atol
        break;
    end
    beta = rsqrnew / rsqr;
    p = - r + beta * p;                        % next search direction
    rsqr = rsqrnew;
end

