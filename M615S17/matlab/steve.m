function [x, U] = steve(m,ff,alpha,beta)
% STEVE solves u'' = f(x), u(0) = alpha, u(1) = beta
% Example:
%   >> f = @(x) sin(x)
%   >> a = 0,  b = 1
%   >> [x, U] = steve(999,f,a,b);
% Note this is the same:
%   >> [x, U] = steve(999,@sin,a,b);

h = 1 / (m+1);
x = h : h : m*h;   % [x1 x2 ... xm] = [h 2h ... mh]

c = 1 / h^2;
F = zeros(m,1);
A = zeros(m,m);
for j = 1:m
    F(j) = ff(x(j));
    if j == 1
        F(j) = F(j) - c * alpha;
        A(j,[j, j+1]) = c * [-2, 1];
    elseif j == m
        F(j) = F(j) - c * beta;
        A(j,[j-1, j]) = c * [1, -2];
    else
        A(j,[j-1, j, j+1]) = c * [1, -2, 1];
    end
end

U = A \ F; 
