% Euler method example, as simple as possible.
% Approximately solves
%   dy/dt = -0.7 y,  y(0) = 10
% Everything about this code can be improved!

t = 0
Y = 10
dt = 1
for n = 1:4
  t = t + dt
  Y = Y + dt * (-0.7 * Y)
end
