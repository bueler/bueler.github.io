function [xk, xklist, alphaklist] = bfgsnaive(x0,f,tol,...
                                              maxiter)
% BFGSNAIVE  Quasi-Newton optimization with naive (inefficient) use of BFGS
% updating and back-tracking.  Uses absolute tolerance on the norm of the
% gradient for termination.  This algorithm is sketched in section 2.2 of
% Nocedal & Wright, while Algorithm 6.1 would be much more efficient.
%
% If xk is the current iterate then the search vector is
%    pk = - Bk \ grad f(xk)
% where Bk uses the rank-two update formula (2.19).  Sets B0 = I, so first
% step is just gradient descent.  Back-tracking line search (Alg. 3.1) gives
% alphak in update (xk <-- xk + alphak pk).
%
% Usage:
%    [xk, xklist, alphaklist] = bfgsnaive(x0,f,tol)
% with inputs
%    x0          n-entry column vector with initial iterate (location)
%    f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%                f.m); f() needs to return f(xk) and gradient df(xk) as first
%                two outputs:    [fxk, dfxk] = f(xk)
%    tol         stop when norm of gradient is less than this number
% and outputs
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix
%    alphaklist  step lengths as row vector of length N
%
% Example for Problem P9 in Nocedal & Wright; compare NEWTONBT result and see
% also NEWTONVBFGS:
%   >> x0 = [1.2 1.2]';
%   >> [x, xlist, alphalist] = bfgsnaive(x0,@rosenbrock,1.0e-4);
%
% Requires: BT

if nargin < 4
    maxiters = 100;   % never take more steps than this
end
xk = x0(:);       % force as column
xklist = [xk];
alphaklist = [];
Bk = eye(length(xk),length(xk));
[fxk, dfxk] = f(xk);
for k = 0:maxiters-1
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - Bk \ dfxk;            % solve linear system; \ is Cholesky because
                                 %   Bk is symmetric pos. def.; O(n^3) step
    if dfxk' * pk < 0.0
         alphak = bt(xk,pk,f,dfxk);
    else
         warning('not descent direction ... unable to do backtracking')
         alphak = 1.0;
    end
    sk = alphak * pk;
    xk = xk + sk;                % update xk
    xklist = [xklist xk];        % append to list
    alphaklist = [alphaklist alphak];
    [fxk, dfnew] = f(xk);
    yk = dfnew - dfxk;
    zk = Bk * sk;
    % do rank-two BFGS update:
    Bk = Bk - (zk * zk') / (sk' * zk) + (yk * yk') / (sk' * yk);
    dfxk = dfnew;                % discard old gradient
end
