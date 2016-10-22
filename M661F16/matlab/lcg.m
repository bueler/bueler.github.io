function [x, xlist] = lcg(x0,A,b,...
                          atol,maxiter)
% LCG  The linear conjugate gradient method.  This is Algorithm 5.2 in
% Nocedal & Wright.
%
% Usage:
%   [x, xlist] = lcg(x0,A,b,atol,maxiter)
% where
%   x     = final result; approximate solution to Ax=b; length n column vector
%   xlist = OPTIONAL: list of iterates
%   x0    = user-provided initial iterate; set to zero if unknown
%   A     = n x n symmetric positive-definite matrix
%   b     = length n column vector for right-hand side of system Ax=b
%   atol  = OPTIONAL: absolute tolerance (terminates if k==n or ||r_k||<atol);
%           defaults to 1.0e-8
%   maxiter = OPTIONAL: maximum number of iterations; defaults to n
%
% Fixed sizer example:
%   >> A = randn(4,4);  A = A' * A;    % symmetric positive definite
%   >> b = randn(4,1);
%   >> xChol = A \ b;
%   >> x0 = zeros(4,1);
%   >> xLCG = lcg(x0,A,b,1.0e-10);
%   >> norm(A * xLCG - b)
%   >> norm(xLCG - xChol)
%
% Big example:
%   >> N = 2000; A = randn(N,N); A = A '* A + eye(N,N); b = randn(N,1);
%   >> x0=zeros(N,1);
%   >> [x, xlist] =lcg(x0,A,b,1.0e-16);
%   >> norm(A*x - b)/norm(b),  size(xlist,2)

% do checks
n = size(A,1);
if size(A,2) ~= n,  error('A must be square'),  end
b = b(:);        % force into column
if length(b) ~= n,  error('b must be  n x 1  if A is  n x n'),  end
if nargin < 4,  atol = 1.0e-8;  end
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

