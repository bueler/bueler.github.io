function [xk,lamk,xklist,lamklist] = popdip(x0,f,tol,maxiters,mu0,theta,kappa)
% POPDIP  POsitive-variables Primal-Dual Interior Point method
% documented by: http://bueler.github.io/M661F18/popdip/popdip.pdf
% Example:
%   >> format long g
%   >> [xk,lamk,xklist]=popdip([2;2],@quickquad,1.0e-8); xk,lamk,xklist'

if nargin < 3,  tol = 1.0e-4;    end
if nargin < 5,  maxiters = 200;  end
if nargin < 5,  mu0 = 1.0;       end
if nargin < 6,  theta = 0.2;     end
if nargin < 7,  kappa = 0.9;     end

if any(x0 <= 0.0),  error('initial iterate must be strictly feasible'),  end
xk = x0(:);                      % force into column shape
mu = mu0;
lamk = mu ./ x0;
n = length(xk);
if nargout > 2
    xklist = [xk];
    lamklist = [lamk];
end

for k = 1:maxiters
    [fxk, dfxk, Hfxk] = f(xk);
    if merit(xk,lamk,dfxk) < tol
        break
    end
    M = [Hfxk,       -eye(n,n);
         diag(lamk), diag(xk)];
    c = [-dfxk + lamk;
         - lamk .* xk + mu];
    p = M \ c;                  % presumably Gaussian elimination: O(n^3)
    dx = p(1:n);
    dlam = p(n+1:2*n);
    alphaP = ratiotest(xk,dx,kappa);
    alphaD = ratiotest(lamk,dx,kappa);
    xk = xk + alphaP * dx;
    lamk = lamk + alphaD * dlam;
    if nargout > 2
        xklist = [xklist xk];
        lamklist = [lamklist lamk];
    end
    mu = theta * mu;
end
end % function

    function z = merit(x,lam,dfx)
    z = max(norm(dfx-lam),norm(lam.*x));
    end % function

    function alpha = ratiotest(x,dx,kappa)
    alpha = 1.0;
    for j = 1:length(x)
        if dx(j) < 0
            alpha = min(alpha, - kappa * x(j) / dx(j));
        end
    end
    end % function

