function z = richardson(A,b,x0,omega,N)
% RICHARDSON  Do N steps of Richardson iteration.
% Usage:
%   >> z = richardson(A,b,x0,omega,N)

z = x0;
for k = 1:N
  z = z + omega * (b - A * z);
end
