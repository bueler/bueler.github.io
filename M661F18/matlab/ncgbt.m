function [xk, xklist] = ncgbt(x0,f,tol,maxiters)
% NCGBT  Nonlinear conjugate gradients (NCG) with back-tracking line search.
% Implements Algorithm 13.3 in Griva, Nash, Sofer (2009), the Fletcher-Reeves
% version of NCG.  Stopping criterion is tolerance on the norm of the gradient.
% Usage:
%    [xk, xklist] = ncgbt(x0,f,tol,maxiters)
% where
%    x0          vector with initial iterate
%    f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%                f.m); f() needs to return function value f(x_k) and gradient
%                grad f(x_k) as first two outputs:    [fxk, dfxk] = f(xk)
%    tol         stop when norm of gradient is less than this number
%    maxiters    maximum number of allowed iterations [default=20000]
% and (outputs)
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix

if nargin < 4,  maxiters = 20000;  end
xk = x0(:);                      % force into column shape
if nargout > 1,  xklist = [xk];  end
pk = zeros(size(xk));
for k = 0:maxiters
    [fxk, dfxk] = f(xk);
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    if k > 0
        betak = dfxk'*dfxk / (olddf'*olddf);
    else
        betak = 0;
    end
    pk = - dfxk + betak * pk;    % for conjugacy, turn from steepest descent
    if dfxk'*pk >= 0
        fprintf('p not descent direction at step %d ... steepest-descent\n',k)
        pk = - dfxk;
    end
    alpha = bt(xk,pk,dfxk,f);    % back-tracking line search
    xk = xk + alpha * pk;
    olddf = dfxk;
    if nargout > 1,  xklist = [xklist xk];  end
end
end % function

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
    end % function

