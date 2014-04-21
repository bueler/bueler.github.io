function u = barenblatt(x,t,u0)
% BARENBLATT  Compute Barenblatt solution  u(x,t)  of the porous medium
% equation
%     u_t = (u^2 u_x)_x
% with the particular value  u(0,1) = u0.
% Example:
%   >> x = -10:.02:10;  u = barenblatt(x,1,2);   plot(x,u)

u = zeros(size(x));
xm = 2 * t^0.25 * u0;
u(abs(x) < xm) = t^(-0.25) * (u0^2 - x(abs(x) < xm).^2 / (4 * t^0.5)).^0.5;
