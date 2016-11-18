function [xk, xklist, alphaklist] = newtonsolve(x0,rr,JJ,...
                                                atol,maxiters,linesearch)
% NEWTONSOLVE  Newton's method for solving equations
%    r(x) = 0
% with back-tracking line search and an absolute tolerance on the norm of the
% residuals.  This is Alg. 11.4 of Nocedal & Wright.  If x_k is the current
% iterate then the search vector p_k solves
%    J(x_k) p_k = - r(x_k)
% Uses sum-of-squares merit function.  By default, back-tracking line search
% is applied to get alpha_k in update
%    x_{k+1} = x_k + alpha_k p_k
%
% Usage:
%    [xk, xklist, alphaklist] = newtonsolve(x0,rr,JJ,atol,maxiters,linesearch)
% with inputs
%    x0          n-entry column vector with initial iterate (location)
%    rr          function handle for residuals:  r(x) is column vector of
%                length n
%    JJ          function handle for Jacobian:  J(x) is n x n matrix
%    atol        stop when norm of residuals is less than this number
%    maxiters    stop when done with this many iterations
%    linesearch  one of: 'none', 'bt' [default], 'rcmbt'
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

if nargin < 4,  atol = 1.0e-6;  end
if nargin < 5,  maxiter = 100;  end
if nargin < 6,  linesearch = 'bt';  end

if ~(strcmp(linesearch,'none') | strcmp(linesearch,'bt') | strcmp(linesearch,'rcmbt'))
    error('linesearch must be one of ''none'', ''bt'', ''rcmbt''')
end

MM = @(x) 0.5 * norm(rr(x))^2;   % sum-of-squares merit function

xk = x0(:);                      % force as column
xklist = [xk];
alphaklist = [];
for k = 1:maxiters
    rk = rr(xk);
    if norm(rk) < atol           % absolute tolerance on gradient f
        break
    end
    Jk = JJ(xk);
    pk = - Jk \ rk;              % nontrivial Newton step; \ is Gauss elim
    if strcmp(linesearch,'none')
        xk = xk + pk;
    else
        gradMk = Jk' * rk;       % grad M(xk)
        if gradMk' * pk < 0
            if strcmp(linesearch,'bt')
                alphak = bt(xk,pk,MM,gradMk);
            else
                rc = rcond(Jk);
                if rc < 1.0e-2
                    lam = rc / 1.0e-2;
                    RCMM = @(x) lam * MM(x) + (1.0 - lam) * 0.5 * norm(x)^2;
                    rcgradMk = lam * Jk' * rk + (1.0 - lam) * xk;
                    alphak = bt(xk,pk,RCMM,rcgradMk);
                else
                    alphak = bt(xk,pk,MM,gradMk);
                end
            end
        else
            error('not a merit-function descent direction ... impossible')
        end
        xk = xk + alphak * pk;
        alphaklist = [alphaklist alphak];
    end
    xklist = [xklist xk];        % append to list
end

