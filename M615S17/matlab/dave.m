function [x, U] = dave(m,verif,ff,alpha,beta)
% DAVE solves u'' = f(x), u(0) = alpha, u(1) = beta
% including a verification case where the error is reported
% Example of general usage:
%   >> f = @(x) exp(-x.^2)
%   >> a = 2,  b = -3
%   >> [x, U] = dave(999,false,f,a,b);
% Example of verification case in which errors are reported
%   >> [x, U] = dave(10,true);
%   >> [x, U] = dave(100,true);
%   >> [x, U] = dave(1000,true);

if (nargin < 3)
    ff = @(x) sin(x);
end
if (nargin < 4)
    alpha = 0;
end
if (nargin < 5)
    beta = 1;
end

h = 1 / (m+1);
x = h : h : m*h;   % [x1 x2 ... xm] = [h 2h ... mh]

c = 1 / h^2;
F = zeros(m,1);
A = zeros(m,m);
for j = 1:m
    F(j) = ff(x(j));
    if j == 1
        F(j) = F(j) - c * alpha;
        A(j,[j, j+1]) = c * [-2.0, 1.0];
    elseif j == m
        F(j) = F(j) - c * beta;
        A(j,[j-1, j]) = c * [1.0, -2.0];
    else
        A(j,[j-1, j, j+1]) = c * [1.0, -2.0, 1.0];
    end
end

U = A \ F; 

if (verif)
    uexact = (-sin(x) + (1.0 + sin(1.0)) * x)';
    errnorm = max(abs(U - uexact));  % ||.||_\infty
    printf('error norm = %e\n',errnorm);
end

endfunction
