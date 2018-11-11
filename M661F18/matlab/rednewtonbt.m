function [xk, xklist] = rednewtonbt(x0,f,A,b,tol)
% REDNEWTONBT  Apply the reduced Newton method with back-tracking to the
% equality-constrained optimization problem
%    min  f(x)
%    s.t. A*x = b
% where f is twice-differentiable and A has full row rank.
% Usage:   [xk, xklist] = rednewtonbt(x0,f,A,b,tol)
% where
%    x0          vector with initial iterate; MUST BE FEASIBLE!
%    f           function handle;
%                f() needs to return three outputs:
%                  * f(x_k)       value
%                  * grad f(x_k)  gradient
%                  * hess f(x_k)  Hessian
%                  i.e.    [fxk, dfxk, Hfxk] = f(xk)
%    tol         stop when norm of gradient is less than this number
% and (outputs)
%    xk          final iterate

% get consistent sizes;  you can pass A=[] and b=[] and it should work
% same as unconstrained Newton
b = b(:);            % force as column vectors
xk = x0(:);
[m n] = size(A);
if length(b) ~= m, error('inconsistent sizes for A,b'), end
if m == 0
    n = length(xk);  % overwrites n=0 if A=[]
else
    if length(xk) ~= n, error('inconsistent sizes for A,x0'), end
end

% null space matrix
Z = nullsp(A,m,n);

% Newton iteration
maxiter = 10000;
xklist = [xk];
for k=1:maxiter
    [fk, dfk, Hfk] = f(xk);
    if norm(dfk) < tol
        break
    end
    r_Hfk = Z' * Hfk * Z;        % wasteful matrix multiplication
    r_dfk = Z' * dfk;
    v = - r_Hfk \ r_dfk;         % this is the reduced Newton direction in {x | Ax=b}
    p = Z * v;
    if dfk' * p >= 0.0
        warning('pk is not a descent direction at iteration %d ... reverting to steepest descent',k)
        p = - dfk;               % revert to steepest descent
    end
    alpha = bt(xk,p,dfk,f);
    xk = xk + alpha * p;
    xklist = [xklist xk];        % append latest point to list
end

    function alpha = bt(xk,pk,dfxk,f)
    % BT Apply backtracking using standard default parameters.
    Dk = dfxk' * pk;
    fxk = f(xk);
    c = 1.0e-4;  % modest sufficient decrease
    rho = 0.5;   % backtracking by halving
    alpha = 1.0;
    while f(xk + alpha * pk) > fxk + c * alpha * Dk
        alpha = rho * alpha;
    end
    end % function bt

    function Z = nullsp(A,m,n)
    % NULLSP Constructs a null space matrix of size  n x (n-m)  for A using
    % the QR decomposition.  Matrix A must have m <= n and full row rank.
    if m == 0
        Z = eye(n);
    else
        if m > n,  error('A must be  m x n  with m <= n'),  end
        [Q R] = qr(A');
        if abs(R(m,m)) < 1.0e-12 * norm(R(:),'inf')
            warning('small R(m,m) value suggests A is rank deficient')
        end
        Z = Q(:,m+1:n);
    end
    end % function mynull

end % function 
