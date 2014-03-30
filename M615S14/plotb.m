% PLOTB  mesh plot of b(x,t)

[x,t] = meshgrid(0:.025:1,0:.03:3);
b = (1/30) * (2 + sin(4 * pi * x)) + 3 * exp(-30 * (t-2).^2);
mesh(x,t,b),  xlabel x,  ylabel t,  zlabel('b(x,t)')
