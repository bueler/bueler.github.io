function [xk, xklist] = newtonbt(x0,f,tol,maxiter)
% NEWTONBT  Newton method with back-tracking for unconstrained optimization
%    min  f(x)
% where f : R^n -> R is twice-differentiable.  Stopping criterion is tolerance
% on the norm of the gradient.
%
% Usage:   [xk, xklist] = newtonbt(x0,f,tol)
% where
%    x0          vector with initial iterate
%    f           function handle;
%                f() needs to return three outputs:  [fxk, dfxk, Hfxk] = f(xk)
%                    * f(x_k)       value
%                    * grad f(x_k)  gradient
%                    * hess f(x_k)  Hessian
%    tol         stop when norm of gradient is less than this number
% and (outputs)
%    xk          final iterate
%    xklist      list of all iterates [optional]
%
% Compare codes SDBT and SR1BT which do not need the Hessian.

if nargin < 4,  maxiter = 100;   end
xk = x0(:);            % force as column vector
if nargout > 1
    xklist = [xk];
end
for k=1:maxiter
    [fk, dfk, Hfk] = f(xk);
    if norm(dfk) < tol
        break
    end
    pk = - Hfk \ dfk;
    if dfk' * pk >= 0.0
        warning('pk is not a descent direction at iteration %d ... reverting to steepest descent',k)
        pk = - dfk;
    end
    alpha = bt(xk,pk,dfk,f);
    xk = xk + alpha * pk;
    if nargout > 1
        xklist = [xklist xk];    % append latest point to list
    end
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

end % function

