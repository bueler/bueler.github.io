function [x, U0, U] = maccormack(JJ,tf,domac)
% MACCORMACK  Try MacCormack scheme on advection-diffusion problem
%   u_t + a u_x = b u_xx
% where a > 0 and b > 0 are constants.  Determines time step from
% the assumption
%   mu = (b dt) / dx^2 = 1/2
% (see problem 5.4 in Morton & Mayers 2nd ed.).  Allows comparison
% to simple upwind.   Example, including plots:
%   >> [x, U0, U] = maccormack(50,3);   max(U)
%   >> subplot(1,2,1),  plot(x,U0,'ko-',x,U,'k*-'),  xlabel x,  ylabel u
%   >> [x, U0, U] = maccormack(200,3);   max(U)
%   >> subplot(1,2,2),  plot(x,U0,'ko-',x,U,'k*-'),  xlabel x

if nargin < 3,  domac = true;  end  % if domac=false do boring upwinding

a = 1;  b = 0.1;  L = 5;
dx = L / JJ;  x = 0:dx:L;
U0 = exp(-5*(x-1).^2);

dt = dx^2 / 2;  % so  mu = 1/2
NN = ceil(tf/dt);  dt = tf / NN;
nu = a * dt / dx;  mu = b * dt / dx^2;

U = U0;
for n = 1:NN
    if domac
        % predictor step
        Up = zeros(size(U));    % includes zero Dirichlet b.c.s
        Up(2:JJ+1) = (1 - nu) * U(2:JJ+1) + nu * U(1:JJ);
        % corrector step
        advt = (nu/2) * ( U(2:JJ) - U(1:JJ-1) + Up(3:JJ+1) - Up(2:JJ) );
        dfus = (mu/2) * ( U(3:JJ+1)  - 2*U(2:JJ)  + U(1:JJ-1) + ...
                        Up(3:JJ+1) - 2*Up(2:JJ) + Up(1:JJ-1) );
    else
        % boring upwind + centered: method (2.147)
        advt = nu * ( U(2:JJ) - U(1:JJ-1) );
        dfus = mu * ( U(3:JJ+1)  - 2*U(2:JJ)  + U(1:JJ-1) );
    end
    Unew = zeros(size(U));  % includes zero Dirichlet b.c.s
    Unew(2:JJ) = U(2:JJ) - advt + dfus;
    U = Unew;  % update    
end
