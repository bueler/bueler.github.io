function [z,N] = gsTOL(A,b,x0,tol)
% GSTOL  Do Gauss-Seidel iteration
%    x_{k+1} = (D - L)^{-1} (b + U x_k)
% until either
%   norm(r_N) = norm(b - A x_N) < tol
% or norm(x_N) > 1e100.  In the latter case, returns N=-1.
% Uses entries of A directly.
% Usage:
%    [z,N] = gsTOL(A,b,x0,tol)
% Example:
%    A = [2 1 0; 0 2 1; 1 0 3];  b = [2 1 4]';  x0 = [0 0 0]';
%    [z,N] = gsTOL(A,b,x0,1.0e-8)

m = size(A,1);
x = x0;
N = 1;
while norm(x) < 1.0e100
    for i = 1:m
        noti = [1:i-1, i+1:m];
        x(i) = (b(i) - A(i,noti) * x(noti)) / A(i,i);
    end
    if norm(b - A * x) < tol
        z = x;
        return
    end
    N = N + 1;
end
N = -1;
z = x;
return
