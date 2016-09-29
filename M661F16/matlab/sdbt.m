function [xk, xklist, alphaklist] = sdbt(x0,f,tol)
% SDBT  Steepest-descent optimization with backtracking and an absolute
% tolerance on the norm of the gradient.  This is the algorithm implied in
% section 2.2 of Nocedal & Wright.  If xk is the current iterate then the
% search vector is
%    pk = - grad f(xk).
% Back-tracking line search is applied to get alphak (bt.m = Algorithm 3.1).
% The next iterate is
%    xk <-- xk + alphak pk
%
% Usage:
%    [xk, xklist, alphaklist] = sdbtfixed(x0,f,tol)
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
% Example, as visualized in slides http://bueler.github.io/M661F16/pits.pdf:
%   >> x0 = [1.5 0.5]';
%   >> x = sdbt(x0,@pits,1.0e-2)
%
% Example for Exercise 3.1 in Nocedal & Wright:
%   >> x0 = [1.2 1.2]';
%   >> [x, xlist, alphalist] = sdbt(x0,@rosenbrock,1.0e-4);
%   >> plot(alphalist,'ko'),  grid on     % plot step lengths
%   >> xlabel k, ylabel('\alpha_k')
%
% Requires: BT

maxiters = 20000;   % never take more steps than this
xk = x0(:);         % force as column
xklist = xk;
alphaklist = [];
for k = 1:maxiters
    [fxk, dfxk] = f(xk);
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    pk = - dfxk;                 % steepest descent
    alphak = bt(xk,pk,f,dfxk);   % back-tracking line search
    xk = xk + alphak * pk;
    xklist = [xklist xk];        % append to list
    alphaklist = [alphaklist alphak];
end
