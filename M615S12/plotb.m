% PLOTB  mesh plot of b(x,t) for #2 on A#6
[x,t] = meshgrid(0:.01:1,0:.03:3);
% b(x,t) = (1/30) (2 + \sin(4 \pi x)) + 3 e^{-30 (t-2)^2}
b = (1/30) * (2 + sin(4 * pi * x)) + 3 * exp(-30 * (t-2).^2);
mesh(x,t,b),  xlabel x,  ylabel t,  zlabel('b(x,t)')
