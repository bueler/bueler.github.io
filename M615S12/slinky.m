function zN = slinky(N)
% SLINKY  Compute configuration of N masses with springs between,
% hanging vertically, scaled so that as N -> infinity, the result
% is slinky-like.  Draw a nice picture of it.

if nargin < 1, N=30; end  % if user does not give N, choose it

g = 9.81;      % m s-2     table
m = 0.1;       % kg        measured total mass
L = 0.06;      % cm        measured relaxed length

k0 = 0.025;    % N         *roughly* estimated spring constant scale;
               %           note that extended length is 1.06 m

dx = L / N;         % m       x is unstretched location of piece
dm = m / N;         % kg      mass of each piece; = lambda * dx
k = k0 / dx;        % N m-1   spring constant for each piece

% set up linear system  A z = b
b = zeros(N,1);
A = sparse(N,N);
A(1,1) = 1;
b(1) = 0;
for i = 2:N-1
  % force balance:  0 = - k (z(i) - z(i-1)) + k (z(i+1) - z(i)) + dm g
  A(i,[i-1 i i+1]) = [k, -2*k, k];
  b(i) = - dm * g;
end
A(N,[N-1 N]) = [k, -k];
b(N) = - dm * g;

z = A \ b;   % z(i) is vertical position of i-th mass
zN = z(N);   % the length of the slinky is returned by >> slinky(N)

% make a figure:  these are cute details only!
sign = 1;
w = ones(N,1);
for i=1:N
  w(i) = w(i) * sign;
  sign = sign * (-1);
end
plot(w+2,-z,'linewidth',2)  % draw slinky (blue is default)
hold on, plot([0 0],[-1.3 0],'r') % red axis with marks
plot([-0.2 0.2],[0 0],'r'),   text(-0.7,0,'x = 0','color','r')
plot([-0.2 0.2],[-1 -1],'r'), text(-0.9,-1,'x = -1 m','color','r')
hold off, axis([-1 4 -1.3 0]), axis off

