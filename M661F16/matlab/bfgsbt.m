function [xk, xklist, alphaklist] = bfgsbt(x0,f,tol,...
                                           maxiters,scaleH0)
% BFGSBT  Quasi-Newton optimization by BFGS updating and back-tracking.
% Uses absolute tolerance on the norm of the gradient for termination.  This
% is Algorithm 6.1 in Nocedal & Wright, plus back-tracking line search
% (Algorithm 3.1).
%
% If xk is the current iterate then the search vector is
%    pk = - Hk * grad f(xk)
% where Hk = Bk^-1 uses the update formulas (6.14) and (6.17).  Sets H1 by
% formula (6.20) to modify H0 before H1.
%
% While BFGSNAIVE does O(n^3) work per iteration, this implementation does
% 12 n^2 + O(n) work per iteration.
%
% Usage:
%    [xk, xklist, alphaklist] = bfgsbt(x0,f,tol)
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
% Example for Problem P9 in Nocedal & Wright; compare NEWTONBT result:
%   >> x0 = [1.2 1.2]';
%   >> [x, xlist, alphalist] = bfgsbt(x0,@rosenbrock,1.0e-4);
%
% Requires: BT
% See also: BFGSNAIVE is less efficient, but same calling sequence
%           COMPAREBFGS shows results for ROSENBROCK from Newton and BFGS

if nargin < 5
    scaleH0 = true;
end
if nargin < 4
    maxiters = 100;   % never take more steps than this
end

xk = x0(:);       % force as column
xklist = [xk];
alphaklist = [];
n = length(xk);
Hk = eye(n,n);
[fxk, dfxk] = f(xk);
for k = 0:maxiters-1
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - Hk * dfxk;            % (6.18); mat-vec; cost 2 n^2 + O(n)
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
    rhok = yk' * sk;
    if rhok <= 0                 % curvature condition (6.7)
        warning('curvature condition fails ... resetting to H0 ...')
    end
    if (k == 0) | (rhok <= 0)
        Hk = eye(n,n);
        if scaleH0
            R = (yk' * sk) / (yk' * yk);
            Hk = R * Hk;         % (6.20)
        end
    end
    rhok = 1.0 / rhok;           % (6.14)
    zk = rhok * sk;
    Hk = Hk - (Hk * yk) * zk';   % (6.17):  cost 4 n^2 + O(n)
    Hk = Hk - zk * (yk' * Hk);   %          cost 4 n^2 + O(n)
    Hk = Hk + zk * sk';          %          cost 2 n^2
    dfxk = dfnew;                % discard old gradient
end

