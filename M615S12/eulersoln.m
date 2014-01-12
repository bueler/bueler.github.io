function y = eulersoln(N)
% EULERSOLN  Solve the system
%    y' = v
%    v' = -4 y - 5 v
% with initial values y(1)=0, v(1)=2, by Euler's method, to compute y(3), v(3).
% Example:   >> eulersoln(100)

Y = [0 2];
dt = (3-1)/N;  % = (tf - t0)/N
for n = 1:N
  % note y = Y(1), v = Y(2):
  Y = Y + dt * [Y(2), -4 * Y(1) - 5 * Y(2)];
end
y = Y(1);
