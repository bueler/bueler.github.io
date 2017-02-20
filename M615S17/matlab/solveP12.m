function [x,U,A,err] = solveP12(m,a,b,alpha,beta)
% SOLVEP12  Verifiable code to solve problem stated in P12(a).
% Example of verification case:
%   >> [x,U,A,err] = solveP12(m);
% General usage:
%   >> [x,U,A] = solveP12(m,a,b,alpha,beta);

if nargin < 2,  a = 0;  end       % set defaults for verification case
if nargin < 3,  b = 1;  end
if nargin < 4,  alpha = 2;  end
if nargin < 5,  beta = 3;  end

% assemble grid, A, F
h = (b - a) / (m + 1);
x = (a+h:h:b-h)';
A = sparse(m,m);                  % faster than "zeros(m,m)" ... why?
F = zeros(m,1);
A(1,[1,2])   = [-2.0/h^2 + 1.0, 1.0/h^2];
A(m,[m-1,m]) = [1.0/h^2, -2.0/h^2 + 1.0];
F(1) = - alpha/h^2;
F(m) = - beta/h^2;
for j = 2:m-1
   A(j,[j-1,j,j+1]) = [1.0/h^2, -2.0/h^2 + 1.0, 1.0/h^2];
end

% solve (and report if in verification case)
U = A \ F;
if (nargin == 1)
    c1 = (3.0 - 2.0*cos(1.0)) / sin(1.0);   c2 = 2.0;
    Uexact = c1 * sin(x) + c2 * cos(x);
    err = norm(U-Uexact,'inf');
end
