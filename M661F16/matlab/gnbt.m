function [xk, xklist, alphaklist] = gnbt(x0,phi,t,y,tol)
% GNBT  Gauss-Newton solution of nonlinear least-squares using back-tracking
% line search and an absolute tolerance on the norm of the gradient.  This
% algorithm is from section 10.3 of Nocedal & Wright.  It minimizes
%     f(x) = (1/2) sum_j=1^m r_j(x)^2
% where
%     r_j(x) = phi(x;t_j) - y_j
% and  t  and  y  are vectors of length m ("data") and  phi(x;t)  is a model
% which we seek to fit to the data by minimizing f.  The user must supply both
% phi and d(phi)/dx.
%
% Usage:
%    [xk, xklist, alphaklist] = gnbt(x0,phi,t,y,tol)
% with inputs
%    x0          n-entry column vector with initial iterate; these are initial
%                estimates of the best-fit parameters
%    phi         function handle which returns phi(x,t) and dphidx(x,t), i.e.
%                    [PHI, dPHI] = phi(x,t)
%                where x is a vector of length n, and t, PHI are all scalars,
%                and dPHI is a vector of length n (= the derivatives dphi/dx_j)
%    t           independent coordinates of data; length m vector
%    y           dependent coordinates of data; length m vector
%    tol         stop when norm of gradient is less than this number
% and outputs
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix
%    alphaklist  step lengths as row vector of length N
%
% Example:
%   >> FIXME
%
% Compare: NEWTONBT, BFGSBT

t = t(:);
y = y(:);
if length(t) ~= length(y)
    error('t,y must be data vectors of the same length m')
end
m = length(t);

% set up backtracking
alphabar = 1.0;
c = 1.0e-4;
rho = 0.5;

% run Gauss-Newton
maxiters = 100;   % never take more steps than this
xk = x0(:);       % force as column
n = length(xk);
xklist = [xk];
alphaklist = [];
for k = 1:maxiters
    % set up and solve Gauss-Newton equations (10.23):  J' J p = - J' r
    rr = zeros(m,1);
    JJ = zeros(m,n);             % an alternative is (10.27) to form J'J
    for j = 1:m
        [PHI, dPHI] = phi(xk,t(j));
        rr(j) = PHI - y(j);
        JJ(j,:) = dPHI';
    end
    dfxk = JJ' * rr;
    if norm(dfxk) < tol          % absolute tolerance on gradient f
        break
    end
    Hfxk = JJ' * JJ;             % Gauss-Newton says use this estimate
                                 % of Hessian; Newton step is normal equations
    pk = - Hfxk \ dfxk;          % nontrivial Newton step; \ is Cholesky
    Dk = dfxk' * pk;
    if Dk >= 0.0
        error('not descent direction ... does Jacobian J have full rank?')
    end
    % implement Algorithm 3.1 = back-tracking
    alphak = alphabar;
    fxk = 0.5 * rr' * rr;          % = f(xk)
    for q = 1:20                   % assume rho^20 is small
        fxap = 0.0;                % = f(xk + alphak * pk)
        for j = 1:m
            [PHI, discard] = phi(xk + alphak * pk,t(j));
            fxap = fxap + (PHI - y(j))^2;
        end
        fxap = 0.5 * fxap;
        if fxap <= fxk + c * alphak * Dk
            break;
        end
        alphak = rho * alphak;
    end
    if q == 20,  error('too many back-tracking steps ... stopping'),  end
    % take step
    xk = xk + alphak * pk;
    xklist = [xklist xk];        % append to list
    alphaklist = [alphaklist alphak];
end

