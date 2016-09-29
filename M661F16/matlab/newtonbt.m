function [xk, xklist, alphaklist] = newtonbt(x0,f,tol)
% NEWTONBTFIXED  Newton optimization with back-tracking and an absolute
% tolerance on the norm of the gradient.  This algorithm is implied in
% section 2.2 of Nocedal & Wright.  If xk is the current iterate then the
% search vector is
%    pk = - H f (xk) \ grad f(xk).
% Back-tracking line search is applied to get alphak (bt.m = Algorithm 3.1).
% The next iterate is
%    xk <-- xk + alphak pk
%
% Usage:
%    [xk, xklist, alphaklist] = newtonbt(x0,f,tol)
% with inputs
%    x0          n-entry column vector with initial iterate (location)
%    f           function handle (e.g. "f" if f is anonymous or "@f" if f is
%                f.m); f() needs to return f(xk), gradient df(xk), and Hessian
%                Hf(xk) as first three outputs:    [fxk, dfxk, Hfxk] = f(xk)
%    tol         stop when norm of gradient is less than this number
% and outputs
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix
%    alphaklist  step lengths as row vector of length N
%
% Example, as visualized in slides http://bueler.github.io/M661F16/pits.pdf:
%   >> x0 = [1.5 0.5]';
%   >> x = newtonbt(x0,@pits,1.0e-2)
%
% Example for Exercise 3.1 in Nocedal & Wright:
%   >> x0 = [1.2 1.2]';
%   >> [x, xlist, alphalist] = newtonbt(x0,@rosenbrock,1.0e-4);
%   >> all(alphalist==1.0)    % = true; back-tracking never kicked in
%
% Requires: BT

maxiters = 100;   % never take more steps than this
xk = x0(:);       % force as column
xklist = [xk];
alphaklist = [];
for k = 1:maxiters
    [fxk, dfxk, Hfxk] = f(xk);
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - Hfxk \ dfxk;          % nontrivial Newton step: \ = Gauss elim
    if dfxk' * pk < 0.0
         alphak = bt(xk,pk,f,dfxk);
    else
         warning('not descent direction ... unable to do backtracking')
         alphak = 1.0;
    end
    xk = xk + alphak * pk;
    xklist = [xklist xk];        % append to list
    alphaklist = [alphaklist alphak];
end
