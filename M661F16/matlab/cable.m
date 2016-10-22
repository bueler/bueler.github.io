function [f, df, A, b] = cable(u,n,C);
% CABLE Objective function associated to a problem of minimum energy of
% a hanging cable.  This example is a case in which we want the dimension
% of the input u to be as large as possible.  The objective is a quadratic
% function of the form  f(x) = (1/2) x' A x - b' x
%
% Usage:      [f, df, A, b] = cable(u,n,C)
% where
%     f  = function value (elastic plus potential energy of cable)
%     df = gradient of f
%     A  = OPTIONAL: Hessian of system; tridiagonal SPD n x n sparse matrix
%     b  = OPTIONAL: right-hand-side of linear system  A x = b
%     u  = vector of length n (= vertical displacements of cable)
%     n  = dimension of problem (number of interior points along cable)
%     C  = constant (weight per unit length of cable)
%
% Example:
%   >> u = [-1 -2 -1]';                 % dimension = 3
%   >> [f, df] = cable(u,3,10)
%
% Example with optimization by code SDBT:
%   >> u0 = [-0.5 -1 -1 -1 -0.5]';      % dimension 5
%   >> f = @(u) cable(u,5,10);          % create function of u only
%   >> f(u0)                            % confirm f(x) works in dim=5
%   >> [uk, uklist, alphaklist] = sdbt(u0,f,1.0e-4);
%   >> h = 1/6;  x = h:h:1-h;           % show result as cable
%   >> plot(x,uk,'ko-',x,u0,'k*-')
%
% See also BT, SDBT, BFGSNAIVE for solution methods.

u = u(:);   % force into column
if length(u) ~= n,  error('input u must be of dimension n');  end

% function value
h = 1.0 / (n+1);    % subinterval length
f = u(1)^2 + u(n)^2;
for j = 1:n-1
    f = f + (u(j+1) - u(j))^2;
end
f = h * ( (0.5 / h^2) * f + C * sum(u) );

% gradient
df = zeros(size(u));
df(1) = (1.0 / h^2) * (2.0 * u(1) - u(2)) + C;
for j = 2:n-1
    df(j) = (1.0 / h^2) * ( 2.0 * u(j) - u(j-1) - u(j+1) ) + C;
end
df(n) = (1.0 / h^2) * (2.0 * u(n) - u(n-1)) + C;
df = h * df;

% additional output if desired:  A = grad^2 f  and RHS  b
if nargout > 2
    A = (1/h) * spdiags([-ones(n,1), 2*ones(n,1), -ones(n,1)], [-1 0 1], n, n);
    b = - h * C * ones(n,1);
end

