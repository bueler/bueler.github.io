function [x, xlist] = lcg(x0,A,b,...
                          atol,maxiter)
% LCG  The linear conjugate gradient method.  This is Algorithm 5.2 in
% Nocedal & Wright.  Requires that  A  be a symmetric positive definite (SPD)
% matrix.  Suitable for approximate solution to large SPD systems.
%
% Usage:
%   [x, xlist] = lcg(x0,A,b,atol,maxiter)
% where
%   x     = final result; approximate solution to Ax=b; length n column vector
%   xlist = OPTIONAL: list of iterates
%   x0    = user-provided initial iterate; set to zero if unknown
%   A     = n x n symmetric positive-definite matrix
%   b     = length n column vector for right-hand side of system Ax=b
%   atol  = OPTIONAL: absolute tolerance; terminates if ||r_k|| < atol;
%           defaults to 0 so runs maxiter steps
%   maxiter = OPTIONAL: maximum number of iterations; defaults to n
%
% Fixed size example:
%   >> A = randn(4,4);  A = A' * A + eye(4,4);  % symmetric positive definite
%   >> b = randn(4,1);
%   >> x0 = zeros(4,1);
%   >> x = lcg(x0,A,b);
%   >> norm(A * x - b)
%   >> x2 = A \ b;
%   >> norm(x - x2)
%
% Bigish example:
%   >> N = 1000; A = randn(N,N); A = A '* A + eye(N,N); b = randn(N,1);
%   >> x0=zeros(N,1);
%   >> [x, xlist] =lcg(x0,A,b,1.0e-6);
%   >> norm(A*x - b)/norm(b),  size(xlist,2)
% (Result is o.k. ... but preconditioning needed.)

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
    if nargout > 1,  xlist = [xlist x];  end   % append x to list
    r = r + alpha * Ap;
    rsqrnew = r' * r;
    if sqrt(rsqrnew) < atol
        break;
    end
    beta = rsqrnew / rsqr;
    p = - r + beta * p;
    rsqr = rsqrnew;
end

