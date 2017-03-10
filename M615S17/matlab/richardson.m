function z = richardson(A,b,x0,N,omega)
% RICHARDSON  Do N steps of Richardson iteration
%    x_{k+1} = x_k + omega (b - A x_k)
% to produce z = x_N.
% Usage:    z = richardson(A,b,x0,N,omega)
% Example:
%    A = [2 1 0; 0 2 1; 1 0 3];  b = [2 1 4]';  x0 = [0 0 0]';
%    z = richardson(A,b,x0,3,1/5)

x = x0;
for k = 1:N
    x = x + omega * (b - A * x);
end
z = x;
