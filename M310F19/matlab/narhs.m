function dudt = narhs(t,u);
% NARHS describes the ODE system for the problem in NEARASTEROID:
%     du/dt = narhs(t,u)
% where u = [xe1,xe2, xa1,xa2, ve1,ve2, va1,va2]'.
% Note the differential equation of a moving
% mass m at position x with velocity v is
%     dx/dt = v
%     dv/dt = (1/m) F
% where F is the total force of gravity from the other masses.  For a
% mass m at position x, the gravity force from a mass M at position Y is
%     F = - (G m M / |x-Y|^3) (x-Y)

G = 6.67430e-11;  % m^3 kg^-1 s^-2
ms = 1.98847e30;  % kg
me = 5.9722e24;   % kg
ma = 1.0e16;      % kg; see 10^15 -- 5x10^17 range at
                  %     https://en.wikipedia.org/wiki/Chicxulub_impactor

dudt = zeros(length(u),1);
dudt(1:4) = u(5:8);
Ces = G*ms / norm(u(1:2))^3;
Cas = G*ms / norm(u(3:4))^3;
Cea = G*ma / norm(u(1:2)-u(3:4))^3;
Cae = G*me / norm(u(1:2)-u(3:4))^3;
dudt(5:6) = - Ces * u(1:2) - Cea * (u(1:2) - u(3:4));
dudt(7:8) = - Cas * u(3:4) - Cae * (u(3:4) - u(1:2));

