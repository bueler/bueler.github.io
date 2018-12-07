function [xk,lamk,xklist,lamklist] = popdip(x0,f,tol,maxiters,mu0,theta,kappabar)
% POPDIP  POsitive-variables Primal-Dual Interior Point method.  This is a
% version of Algorithm 16.1 in section 16.7 of Griva, Nash, Sofer (2009).
% Uses mu_k and kappa formulas in section 16.7.2.  It appears the convergence
% of this algorithm it quadratic; it should be governed by Theorem 16.17.
%     This implementation does not use back-tracking; only the ratio test
% for positivity, both primal and dual, adjusts the step size.  This
% implemenation does not exploit any sparsity; the indefinite Newton step
% equations are solved by O(n^3) Gauss elimination.
%
% Documented by: http://bueler.github.io/M661F18/popdip/doc.pdf
%
% Example:   See TESTPOPDIP.

if nargin < 3,  tol = 1.0e-4;    end
if nargin < 4,  maxiters = 200;  end
if nargin < 5,  mu0 = 1.0;       end
if nargin < 6,  theta = 0.1;     end
if nargin < 7,  kappabar = 0.9;  end

if any(x0 <= 0.0),  error('initial iterate must be strictly feasible'),  end
xk = x0(:);                      % force into column shape
lamk = mu0 ./ xk;                % this is the only place mu0 is used; needed
n = length(xk);
if nargout > 2
    xklist = [xk];
    lamklist = [lamk];
end

for k = 1:maxiters
    [fxk, dfxk, Hfxk] = f(xk);
    meritk = merit(xk,lamk,dfxk);
    if meritk < tol
        break
    end
    mu = min(theta*meritk,meritk^2);    % formula page 646
    M = [Hfxk,       -eye(n,n);
         diag(lamk), diag(xk)];
    c = [-dfxk + lamk;
         - lamk .* xk + mu];
    p = M \ c;                  % presumably Gaussian elimination: O(n^3)
    dx = p(1:n);
    dlam = p(n+1:2*n);
    kappa = max(kappabar,1.0-meritk);   % formula page 646
    alphaP = ratiotest(xk,dx,kappa);
    alphaD = ratiotest(lamk,dx,kappa);
    xk = xk + alphaP * dx;
    lamk = lamk + alphaD * dlam;
    if nargout > 2
        xklist = [xklist xk];
        lamklist = [lamklist lamk];
    end
end
end % function

    function z = merit(x,lam,dfx)
    % MERIT implements a formula on page 642
    z = max(norm(dfx-lam),norm(lam.*x));
    end % function

    function alpha = ratiotest(x,dx,kappa)
    % RATIOTEST implements a formula on page 642
    alpha = 1.0;
    for j = 1:length(x)
        if dx(j) < 0
            alpha = min(alpha, - kappa * x(j) / dx(j));
        end
    end
    end % function

