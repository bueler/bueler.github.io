function [xk, xklist] = sdfdbt(x0,f,tol,fdgrad,maxiters)
% SDFDBT  Steepest-descent optimization with finite-differenced gradient and
% back-tracking line search.  Stopping criterion is tolerance on the norm of
% the gradient.
% Usage:
%    [xk, xklist] = sdfdbt(x0,f,tol,fdgrad,maxiters)
% where
%    x0          vector with initial iterate
%    f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%                f.m); f() needs to return function value f(x_k) as first
%                output
%    tol         stop when norm of gradient is less than this number
%    fdgrad      boolean flag: true [default] if finite-differenced gradient;
%                false if f() gives gradient as 2nd argument:  [fx,dfx] = f(x)
%                uses gradient CHECK MODE if fdgrad==-1
%    maxiters    maximum allowed number of iterations [default = 20000]
% and (outputs)
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix

if nargin < 4,   fdgrad = true;  end
if nargin < 5,   maxiters = 20000;  end % never take more steps than this
xk = x0(:);                      % force into column shape
if nargout > 1,  xklist = [xk];  end

h = sqrt(eps);                   % see section 12.4;  h ~ 10^{-8}
for k = 1:maxiters
    if fdgrad
        fxk = f(xk);
        dfxk = zeros(size(xk));
        for j = 1:length(dfxk)
            xshift = xk;
            xshift(j) = xk(j) + h;
            dfxk(j) = (f(xshift) - fxk) / h;
        end
        if fdgrad == -1
            [fxk, dfxk2] = f(xk);
            fprintf('\nCHECK MODE:  at x0, gradient difference should be O(1e-7):\n')
            fprintf('             |gradf_fd - gradf_user| = %.4e\n\n',...
                    norm(dfxk-dfxk2))
            error('stopping; this is normal CHECK MODE behavior ...')
        end
    else
        [fxk, dfxk] = f(xk);
    end
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - dfxk;                 % steepest descent
    alpha = bt(xk,pk,dfxk,f);    % back-tracking line search
    xk = xk + alpha * pk;
    if nargout > 1,  xklist = [xklist xk];  end
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

