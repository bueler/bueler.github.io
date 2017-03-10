function z = jacobi(A,b,x0,N)
% JACOBI  Do N steps of Jacobi iteration
%    x_{k+1} = D^{-1} (b + (L + U) x_k)
% to produce z = x_N.  Uses entries of A directly.
% Usage:
%    z = jacobi(A,b,x0,N)
% Example:
%    A = [2 1 0; 0 2 1; 1 0 3];  b = [2 1 4]';  x0 = [0 0 0]';
%    z = jacobi(A,b,x0,3)

m = size(A,1);
x = x0;
xnew = zeros(size(x));
for k = 1:N
    for i = 1:m
        noti = [1:i-1, i+1:m];
        xnew(i) = (b(i) - A(i,noti) * x(noti)) / A(i,i);
    end
    x = xnew;
end
z = x;
