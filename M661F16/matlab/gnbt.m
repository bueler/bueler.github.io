function [xk, xklist, alphaklist] = gnbt(x0,phi,dphi,t,y,tol)
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
%    [xk, xklist, alphaklist] = gnbt(x0,phi,dphi,t,y,tol)
% with inputs
%    x0          n-entry column vector with initial iterate; these are initial
%                estimates of the best-fit parameters
%    phi         function handle which returns phi(x,t) i.e.
%                    PHI = phi(x,t)
%                where x is a vector of length n, and t, PHI are scalars
%    dphi        function handle which returns gradient dphidx(x,t), i.e.
%                    dPHI = dphi(x,t)
%                where x is a vector of length n, and t is a scalars,
%                and dPHI is a column vector of length n (= derivatives dphi/dx_j)
%    t           independent coordinates of data; length m vector
%    y           dependent coordinates of data; length m vector
%    tol         stop when norm of gradient is less than this number
% and outputs
%    xk          Nth iterate
%    xklist      all iterates as N+1 column matrix
%    alphaklist  step lengths as row vector of length N
%
% Example of linear interpolation:
%   >> t = [0, 1]';  y = [3, 5]';
%   >> phi = @(x,t) x(1) + x(2)*t;
%   >> dphi = @(x,t) [1; t];
%   >> x0 = [1, 1]';
%   >> [x,xlist,alphalist] = gnbt(x0,phi,dphi,t,y,1.0e-6);
%
% Example of linear least-squares fit:
%   >> m = 20;  t = (1:m)';  y = (5:2:2*m+3)' + 0.5*randn(m,1);
%   >> phi = @(x,t) x(1) + x(2)*t;
%   >> dphi = @(x,t) [1; t];
%   >> x0 = [1, 1]';
%   >> [x,xlist,alphalist] = gnbt(x0,phi,dphi,t,y,1.0e-6);
%   >> x                % x approximates [3,2]'
%   >> plot(t,y,'ko',t,x(1)+x(2)*t,'k--')
%
% Example of nonlinear least-squares fit:
%   >> t = (0:3)';  y = [3, 1, 2, 1]';
%   >> phi = @(x,t) x(1) * exp(x(2)*t);
%   >> dphi = @(x,t) [exp(x(2)*t); t*x(1)*exp(x(2)*t)];
%   >> x0 = [2, 0]';
%   >> [x,xlist,alphalist] = gnbt(x0,phi,dphi,t,y,1.0e-6);
%   >> tfine = 0:.01:3;
%   >> plot(t,y,'ko',tfine,x(1)*exp(x(2)*tfine),'k--')
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
        rr(j) = phi(xk,t(j)) - y(j);
        JJ(j,:) = dphi(xk,t(j))';
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
        xap = xk + alphak * pk;
        fxap = 0.0;                % = f(xk + alphak * pk)
        for j = 1:m
            fxap = fxap + (phi(xap,t(j)) - y(j))^2;
        end
        fxap = 0.5 * fxap;
        if fxap <= fxk + c * alphak * Dk
            break;
        end
        alphak = rho * alphak;
    end
    if q == 20,  error('too many back-tracking steps ... stopping'),  end
    % take step
    xk = xap;
    xklist = [xklist xk];        % append to list
    alphaklist = [alphaklist alphak];
end

