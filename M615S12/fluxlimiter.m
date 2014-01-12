function fluxlimiter(J,nu,k,init)
% FLUXLIMITER  Solves for u(x,t) at t=k with
%   u_t + u_x = 0  on  0 < x < 1
% with periodic boundary conditions and with either square wave
% initial shape
%   u(x,0) = 1  if 0.3 < x < 0.7,
%            0  otherwise
% or smoother 'hump' initial shape,
%   u(x,0) = cos^2(2 pi (x-0.5))  if 0.25 < x < 0.75
%          = 0                  otherwise.
% Demonstrates four schemes in subplots in one figure: upwind (top),
% Lax-Wendroff (next), and a flux-limited, nonlinear (bottom two).
% The last two subplots differ in their time-integration scheme:
% upper is explicit Euler and lower is an order 2 Runge-Kutta method
% (= modified Euler).
%    The flux-limited scheme is defined in equations (1.2), (1.3), and
% (1.7) of
%    Hundsdorfer and Verwer, "Numerical Solution of Time-Dependent
%    Advection-Diffusion-Reaction Equations", Springer 2003
% which we call "H&V".  The particular flux-limiter is the kappa=1/3
% case of (1.10) in H&V, the Koren (1993) choice.
% Form: fluxlimiter(J,nu,k,init)
% Example:
%    >> fluxlimiter(50,0.5,1,'square')
%    >> fluxlimiter(50,0.33,1,'hump')
%    >> fluxlimiter(100,0.33,10,'square')
%    >> fluxlimiter(100,0.33,10,'hump')
% The first and third arguments are J and k which must be integers.
% The flux-limited scheme requires nu <= 1/2 with explicit Euler
% time integration; see (1.12) in H&V (2003).

if nargin<1,  J = 50;   end
if nargin<2,  nu = 0.5;   end
if nargin<3,  k = 1;   end
if nargin<4,  init = 'square';   end
figure(1), clf

% spatial grid
dx = 1.0 / J;  x  = 0:dx:1-dx;

% initial shape
errstr = 'only "square" and "hump" are allowed as initial';
if length(init)<4, error(errstr), end
init = init(1:4);
if all(init=='squa')
  uinit = ones(size(x));
  uinit(x<0.3) = 0.0;  uinit(x>0.7) = 0.0;   % square wave
elseif all(init=='hump')
  uinit = cos(2*pi*(x-0.5)).^2;
  uinit(x<0.25) = 0.0;  uinit(x>0.75) = 0.0; % smooth hump
else, error(errstr), end

% temporal grid
tf = k * 1.0;
dt = nu * dx;
NN = ceil(tf/dt);
dt = tf / NN;  t  = 0:dt:tf;
fprintf('  doing N=%d steps with dt=%.5e\n',NN,dt)

% u(x,t=tf) = u(x,t=0)   because tf=k (integer) and periodic
xfine = 0:1/600:1;
if all(init=='squa')
  uexact = ones(size(xfine));
  uexact(xfine<0.3) = 0.0;  uexact(xfine>0.7) = 0.0;   % square wave
elseif all(init=='hump')
  uexact = cos(2*pi*(xfine-0.5)).^2;
  uexact(xfine<0.25) = 0.0;  uexact(xfine>0.75) = 0.0; % smooth hump
end

% three numerical schemes
for fig=1:4
      u = uinit;
      for n=1:NN-1
        if fig==1                        % upwind
          fstag = u;
          u = u - nu * (fstag - [fstag(J) fstag(1:J-1)]);
        elseif fig==2                    % Lax-Wendroff
          ustag = 0.5 * (u + [u(2:J) u(1)]);
          fstag = ustag - (nu/2) * ([u(2:J) u(1)] - u);    % dt/2 of Lax-Friedrichs
          u = u - nu * (fstag - [fstag(J) fstag(1:J-1)]);
        else                             % flux-limiter
          theta = gettheta(J,u);
          psi = getpsi(theta);
          %figure(2), hold on, plot(theta,ppsi,'*'), axis([-3 6 -0.5 1.5])
          fstag = u + psi .* ([u(2:J) u(1)] - u);  % add to upwind version
          uEu = u - nu * (fstag - [fstag(J) fstag(1:J-1)]);  % exp Euler
        end
        if fig==3                        % just explicit Euler
          u = uEu;
        elseif fig==4                    % complete RK2 scheme
          theta2 = gettheta(J,uEu);
          psi2 = getpsi(theta2);
          fstag2 = uEu + psi2 .* ([uEu(2:J) uEu(1)] - uEu);
          u = u - (nu/2) * (fstag - [fstag(J) fstag(1:J-1)]) - ...
                    (nu/2) * (fstag2 - [fstag2(J) fstag2(1:J-1)]);
        end
      end
      figure(1), subplot(4,1,fig)
      plot(xfine,uexact,'r')   % exact soln on fine grid
      hold on,  plot(x,u,'o-','markersize',6,'linewidth',1.0)
      hold off, axis([0 1 -0.3 1.3]), axis off
      if fig==1, title('upwind')
      elseif fig==2, title('Lax-Wendroff')
      elseif fig==3, title('flux limiter (Euler)')
      elseif fig==4, title('flux limiter (RK2)')
      end
end

function th = gettheta(J,u)
  th      = u - [u(J) u(1:J-1)];
  denom   = [u(2:J) u(1)] - u;
  no      = (abs(denom) < 1.0e-10);
  th(no)  = 0.0;
  th(~no) = th(~no) ./ denom(~no);
end

function ps = getpsi(theta)
  % This is the Koren (1993) choice, the kappa=1/3 case of (1.10) in H&V.
  ps = min([ones(size(theta)); (1/3)+(1/6)*theta; theta]);
  ps = max(0.0, ps);
end

end  % function fluxlimiter
