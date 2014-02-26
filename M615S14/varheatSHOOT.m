function [x,u,q] = varheatSHOOTmat()
% Set up and solve, by nonlinear shooting, a "serious" linear
% two-point BVP for equilibrium temperature distribution in a rod.
% The terms correspond to variable conductivity, constant
% chemical-reaction-created heat, and variable externally-introduced heat.
% Uses bisection to solve target boundary equation  u(3) = 0.
% ** Matlab version: uses ode45 **
% Example:
%   >> [x,u,q] = varheatSHOOTmat();

L = 3;
k = @(x) 0.5 * atan((x-1.0) * 20.0) + 1.0;
s = @(x) exp(-(x-2.0).^2);
r0 = 0.5;

% ODE  Y' = G(x,Y)  is described by this right-hand side
G = @(x,Y) [- Y(2) / k(x);       % Y(1) = u 
            r0 * Y(1) + s(x)];   % Y(2) = q

% bracket unknown u(0)
a = -10.0;  % produces u(3) which is too high
b =   0.0;  %      ... u(3) which is too low

% unsophisticated bisection method:
N = 100;
for n = 1:N
  fprintf('.')
  c = (a+b)/2;
  % evaluate F(c) =  (estimate of u(3) based on u(0)=c)
  [xout,Y] = ode45(G,[0.0 3.0],[c; 0.0]);
  F = Y(end,1);
  if abs(F) < 1e-12 
    fprintf('\nbisection done; F(A)=%2e using A=%5f\n', F, c)
    break  % we are done
  elseif F >= 0.0 
    a = c;
  else
    b = c;
  end
end
if n >= N, fprintf(' bisection: max iterations reached\n'), end

% redo to get final version on a grid for plot
x = 0:0.05:3.0;
[xout,Y] = ode45(G,x,[c; 0.0]);
u = Y(:,1)';
q = Y(:,2)';
figure(2),  plot(x,k(x),'r',x,s(x),'b',xout,u,'g*',xout,q,'k')
grid on,  xlabel x,  legend('k(x)','s(x)','u(x)','q(x)')
title(sprintf('result of SHOOTING:  u(0) = %.6f',u(1)))

