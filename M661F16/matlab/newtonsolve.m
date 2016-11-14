function [xk, xklist, alphaklist] = newtonsolve(x0,rr,JJ,tol,maxiters,dols)
% NEWTONSOLVE  Newton's method for solving equations
%    r(x) = 0
% with back-tracking line search and an absolute tolerance on the norm of the
% residuals.  This is Alg. 11.4 of Nocedal & Wright.  If xk is the current
% iterate then the search vector pk solves
%    J(xk) pk = - r(xk)
% Back-tracking line search is applied, using a sum of squares merit function,
% to get alphak (bt.m = Algorithm 3.1).
%
% Usage:
%    [xk, xklist, alphaklist] = newtonsolve(x0,rr,JJ,tol,nols)
% with inputs
%    x0          n-entry column vector with initial iterate (location)
%    rr          function handle for residuals:  r(x) is column vector of
%                length n
%    JJ          function handle for Jacobian:  J(x) is n x n matrix
%    tol         stop when norm of residuals is less than this number
%    dols        if true, do line search with merit function
% and outputs
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix
%    alphaklist  step lengths as row vector of length N
%
% Example:
%   >> x0 = [2 2]';
%   >> r = @(x) [x(1) - x(2)^2 + 3; 3*cos(x(1)) + x(2)];
%   >> J = @(x) [1, -2*x(2);  -3*sin(x(1)), 1];
%   >> x = newtonsolve(x0,r,J,1.0e-6)
%
% Requires: BT

if nargin < 4,  tol = 1.0e-6;  end
if nargin < 5,  maxiter = 100;  end
if nargin < 6,  dols = true;  end

MM = @(x) 0.5 * norm(rr(x))^2;   % sum of squares merit function

xk = x0(:);                      % force as column
xklist = [xk];
alphaklist = [];
for k = 1:maxiters
    rk = rr(xk);
    if norm(rk) < tol            % absolute tolerance on gradient f
        break
    end
    Jk = JJ(xk);
    pk = - Jk \ rk;              % nontrivial Newton step; \ is Gauss elim
    if dols
		gradMk = Jk' * rk;           % grad M(xk)
		if gradMk' * pk < 0
		    alphak = bt(xk,pk,MM,gradMk);
		else
		    warning('not a merit-function descent direction')
		    alphak = 1.0;
		end
        xk = xk + alphak * pk;
        alphaklist = [alphaklist alphak];
    else
        xk = xk + pk;
    end
    xklist = [xklist xk];        % append to list
end

