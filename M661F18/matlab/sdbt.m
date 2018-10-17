function [xk, xklist] = sdbt(x0,f,tol)
% SDBT  Steepest-descent optimization with back-tracking line search.  Stopping
% criterion is tolerance on the norm of the gradient.
% Usage:
%    [xk, xklist] = sdbt(x0,f,tol,alpha)
% where
%    x0          vector with initial iterate
%    f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%                f.m); f() needs to return function value f(x_k) and gradient
%                grad f(x_k) as first two outputs:    [fxk, dfxk] = f(xk)
%    tol         stop when norm of gradient is less than this number
% and (outputs)
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix

maxiters = 20000;                % never take more steps than this
xk = x0(:);                      % force into column shape
xklist = [xk];
for k = 1:maxiters
    [fxk, dfxk] = f(xk);
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - dfxk;                 % steepest descent
    alpha = bt(xk,pk,dfxk,f);    % back-tracking line search
    xk = xk + alpha * pk;
    xklist = [xklist xk];        % append latest point to list
end
end % function

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
    end % function
