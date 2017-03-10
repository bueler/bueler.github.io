function z = gs(A,b,x0,N)
% GS  Do N steps of Gauss-Seidel iteration
%    x_{k+1} = (D - L)^{-1} (b + U x_k)
% to produce z = x_N.  Uses entries of A directly.
% Usage:
%    z = gs(A,b,x0,N)
% Example:
%    A = [2 1 0; 0 2 1; 1 0 3];  b = [2 1 4]';  x0 = [0 0 0]';
%    z = gs(A,b,x0,3)

m = size(A,1);
x = x0;
for k = 1:N
    for i = 1:m
        noti = [1:i-1, i+1:m];
        x(i) = (b(i) - A(i,noti) * x(noti)) / A(i,i);
    end
end
z = x;
