function [f, df, Hf] = xrosenbrock(x, mu)
% XROSENBROCK Extended Rosenbrock function in any *even* dimension n.  The
% formula is given in Exercise 7.1 in Nocedal & Wright; compare Exercise 2.1.  
% This funcion is the sum of n/2 copies of the dimension 2 Rosenbrock function
% (see ROSENBROCK).  In dimension n = 4 the formula is
%    f(x) =   mu * (x2 - x1^2)^2 + (1 - x1)^2
%           + mu * (x4 - x3^2)^2 + (1 - x3)^2
%
% Usage:
%   [f, df, Hf] = xrosenbrock(x, mu)
% where:
%   f   = output function value; scalar
%   df  = output gradient; n x 1 vector
%   Hf  = output Hessian; n x n *sparse* matrix
%   x   = input vector in dimension n; n must be even
%   mu  = OPTIONAL scale on quartic terms; DEFAULT is mu = 100
%
% Example:
%   >> x0 = [1.2, 1.2, 1.2, 1.2]';
%   >> [f, df, Hf] = xrosenbrock(x0);
%   >> [x, xlist, alphalist] = bfgsbt(x0,@xrosenbrock,1.0e-4);
%
% See also: ROSENBROCK, BFGSBT

x = x(:);   % force column
n = length(x);
if mod(n,2) ~= 0,  error('dimension n must be even'),  end
if nargin < 2,  mu = 100.0;  end

f = 0;
df = zeros(n,1);
Hf = sparse(n,n);
for j = 1:n/2
   k = 2*j-1:2*j;   % range of two indices
   f = f + mu * (x(k(2)) - x(k(1))^2)^2 + (1 - x(k(1)))^2;
   df(k) = [- 4 * mu * x(k(1)) * (x(k(2)) - x(k(1))^2) - 2 * (1 - x(k(1)));
             2 * mu * (x(k(2)) - x(k(1))^2)];
   Hf(k,k) = [12 * mu * x(k(1))^2 - 4 * mu * x(k(2)) + 2,  - 4 * mu * x(k(1));
              - 4 * mu * x(k(1)),                          2 * mu];
end

