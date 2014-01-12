function U = flipper(J, small)
% FLIPPER  Show that for mu > 1/2 in the explicit scheme, the unstable case,
% we see the sawtooth wave (1) grow in magnitude, and (2) flip sign at every
% step.  And we observe that even small noise grows.  Runs until you stop it.
% See also EXPLICIT.  Example:
%   >> flipper
%   >> flipper(100,1e-4)   % lots of noise

if nargin<1, J = 20; end
if nargin<2, small = 1.0e-10; end

dx = 1.0 / J;  x = 0:dx:1;
mu = 0.7;        % bad mu
dt = mu * dx^2;  % because  mu = dt / dx^2

U = zeros(size(x)); % allocate space
U = sin(2*pi*x) + small * randn(size(x));  % initial condition with noise

figure(1), clf, plot(x,U), xlabel x, ylabel U % draw
axis([0 1 min(-1,min(U)) max(1,max(U))])      % consistent axis choice
% numerically-approximate PDE
while true
  pause(0.5)
  newU = zeros(size(x));
  for j = 2:J
    newU(j) = U(j) + mu * (U(j+1) - 2 * U(j) + U(j-1));
  end
  U = newU;
  figure(1), clf, plot(x,U), xlabel x, ylabel U  % redraw
  axis([0 1 min(-1,min(U)) max(1,max(U))])
end
