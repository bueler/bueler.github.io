% SHOCK will be a code that demos upwind and flux-limited on Burger's eqn

a = @(x,t) (1 + x.^2) ./ (1 + 2 * x * t + 2 * x.^2 + x.^4);
x0char = @(x,t) x - t ./ (1 + x.^2);

uinit = @(x) exp(-10 * (4 * x - 1).^2);

dx = 0.01;
[xx,tt] = meshgrid(0:dx:1,0:dx:1);
uu = uinit(x0char(xx,tt));

mesh(xx,tt,uu)
view(2)
%shading interp
