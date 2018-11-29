function [xk, xklist] = rednewtonbt(x0,f,A,b,tol,maxiter,ctol)
% REDNEWTONBT  Apply the reduced Newton method with back-tracking to the
% equality-constrained optimization problem
%    min  f(x)
%    s.t. A*x = b
% where f : R^n -> R is twice-differentiable, b in R^m, and A is m x n matrix
% with full row rank.  Becomes normal Newton+back-tracking if A=[] and b=[].
% Stopping criterion is tolerance on norm of the gradient.
%
% Usage:   [xk, xklist] = rednewtonbt(x0,f,A,b,tol,maxiter,ctol)
% where
%    x0          vector with initial iterate; MUST BE FEASIBLE!: A*x0=b
%    f           function handle;
%                f() needs to return three outputs:  [fxk, dfxk, Hfxk] = f(xk)
%                    * f(x_k)         value
%                    * grad f(x_k)    n x 1 gradient
%                    * hess f(x_k)    n x n Hessian
%    A           constraint system:   A is  m x n   or []
%    b                                b is  m x 1   or []
%    tol         stop when norm of gradient is less than this number
%    maxiter     max number of iterations [default: 100]
%    ctol        if norm(A*x_k-b) > ctol then warning about x_k not feasible
%                [default: 1.0e-14]
% and (outputs)
%    xk          final iterate
%    xklist      list of all iterates [optional]
%
% Warning:  This implementation is inefficient.  It uses explicit matrix
%           multiplication to build the reduced gradient and Hessian.  It also
%           builds the null space matrix Z explicitly using QR.
%
% Null-space and back-tracking calculations are included here.
% See also MYNULL and other back-tracking-using codes like SDBT and SR1BT.

% optional parameters
if nargin < 6,  maxiter = 100;   end
if nargin < 7,  ctol = 1.0e-14;  end  % tolerance for testing Ax=b constraint

% get consistent sizes; note you can input A=[] and b=[]
b = b(:);            % force as column vectors
xk = x0(:);
[m n] = size(A);
if length(b) ~= m, error('inconsistent sizes for A,b'), end
if m == 0
    n = length(xk);  % correct when A=[] and b=[]
else
    if length(xk) ~= n, error('inconsistent sizes for A,x0'), end
    if m > n,  error('A must be  m x n  with m <= n'),  end
    if norm(A*xk-b) >= ctol, warning('initial iterate not feasible?!'), end
end
if nargout > 1
    xklist = [xk];
end

% if feasible set is one point, we are done; we have checked xk is feasible
% but this assumes A has full rank
if m == n
    return
end

% m x n matrix A must have m <= n and full row rank.
% r = n-m  is dimension of null space of A
% n x r null space matrix Z, built once using the QR decomposition
if m == 0
    Z = eye(n);        % unconstrained case
else
    [Q R] = qr(A');
    if abs(R(m,m)) < 1.0e-12 * norm(R(:),'inf')
        warning('small R(m,m) value suggests A is rank deficient')
    end
    Z = Q(:,m+1:n);    % last r columns of Q
end

% reduced Newton iteration
for k = 1:maxiter
    [fk, dfk, Hfk] = f(xk);
    r_dfk = Z' * dfk;            % reduced gradient
    if norm(r_dfk) < tol
        break
    end
    r_Hfk = Z' * Hfk * Z;        % reduced Hessian
    v = - r_Hfk \ r_dfk;         % reduced search direction
    if r_dfk' * v >= 0.0
        warning('v is not a (reduced) descent direction at iteration %d ... reverting to steepest descent',k)
        v = - r_dfk;             % reduced steepest descent
    end
    p = Z * v;                   % feasible direction; xk+p in subspace {x | Ax=b}
    alpha = bt(xk,p,dfk,f);
    xk = xk + alpha * p;
    if m > 0
        if norm(A*xk-b) >= ctol, warning('iterate %d may not be feasible!',k), end
    end
    if nargout > 1
        xklist = [xklist xk];    % append latest point to list
    end
end

    function alpha = bt(xk,pk,dfxk,f)
    % BT Apply backtracking using standard default parameters.
    Dk = dfxk' * pk;
    fxk = f(xk);
    c = 1.0e-4;                  % modest sufficient decrease
    rho = 0.5;                   % backtracking by halving
    alpha = 1.0;
    while f(xk + alpha * pk) > fxk + c * alpha * Dk
        alpha = rho * alpha;
    end
    end % function bt

end % function

