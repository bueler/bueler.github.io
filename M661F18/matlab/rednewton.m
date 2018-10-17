function [z, x] = rednewton(x0,f,A,b,tol)
% REDNEWTON  Apply the reduced Newton method with back-tracking to the
% equality-constrained optimization problem
%    min  f(x)
%    s.t. A*x = b
% where f is twice-differentiable and A has full row rank.
% Usage:   [z, x] = rednewton(x0,f,A,b,tol)
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
%    x           final iterate
%    z           final objective value  z = f(x)

FIXME


    function alpha = bt(xk,pk,dfxk,f)
    % BT Apply backtracking using standard default parameters.
    Dk = dfxk' * pk;
    fxk = f(xk);
    if Dk >= 0.0,  error('pk is not a descent direction ... stopping'),  end
    c = 1.0e-4;  % modest sufficient decrease
    rho = 0.5;   % backtracking by halving
    alpha = 1.0;
    while f(xk + alpha * pk) > fxk + c * alpha * Dk
        alpha = rho * alpha;
    end
    end % function bt

    function Z = mynull(A)
    % MYNULL Constructs a null space matrix for using the QR decomposition.
    [m n] = size(A);
    if m > n,  error('A must be  m x n  with m <= n'),  end
    [Q R] = qr(A');
    if abs(R(m,m)) < 1.0e-12 * norm(R(:),'inf')
        warning('small R(m,m) value suggests A is rank deficient')
    end
    Z = Q(:,m+1:n);
    end % function mynull

end % function 
