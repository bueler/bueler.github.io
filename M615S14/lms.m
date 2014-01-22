function lms(M,T,dt)
% LMS  simulation of a linear mass-spring system with a particular
% initial configuration.  Usage:
%   lms(M,T,dt)
% has
%   M  = number of masses (must be even)
%   T  = final time
%   dt = time step
% Note N = T / dt is the number of steps.
% Calls SHOWLMS to show each state (i.e. after each time step).
% Uses simplest scheme possible, namely Euler method.
% WARNING:  Not guaranteed to work for all choices (M,T,dt)!
%           We need to understand it better!
% Example:
%   >> lms(4,1.0,0.02)

NN = ceil(T/dt);        % number of time steps
dt = T / NN;            % fix so NN * dt = T exactly
L = 1.0;                % total length
dx = L / (M + 1);       % spacing between equilibrium locations
xe = dx:dx:L-dx;        % equilibrium (relaxed-spring) locations of masses

k = 1.0 / dx;
mu = 1.0 * dx;
R = k * dt / mu;

v = zeros(M,1);           % zero initial velocity
u = [0.1*ones(M/2,1); zeros(M/2,1)];  % zero initial displacement

for n = 1:NN
  for j = 1:M
    if j == 1
      uleft = 0;
    else
      uleft = u(j-1);
    end
    if j == M
      uright = 0;
    else
      uright = u(j+1);
    end
    vnew(j) = v(j) - R * (u(j) - uleft) + R * (uright - u(j));
    unew(j) = u(j) + dt * v(j);
  end
  u = unew;
  v = vnew;
  clf
  showlms(u,L)
  drawnow
end
