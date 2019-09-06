% CLASS5SEPT  Demo in class of 3D plotting using an anonymous function and
% MESHGRID.  Different plotting styles shown including CONTOUR, MESH, SURF,
% and WATERFALL.  Plots
%   z = x^2 - xy + y^3
% on -10 < x < 10 and -5 < y < 5

g = @(x,y) x.^2 - x.*y + y.^3;  % an anonymous function with two inputs

% generate x and y coordinates of every point in a grid
[xx,yy] = meshgrid(-10:.5:10,-5:.2:5);
zz = g(xx,yy);

subplot(2,2,1)
surf(xx,yy,zz)
xlabel x,  ylabel y

subplot(2,2,2)
mesh(xx,yy,zz)
xlabel x,  ylabel y

subplot(2,2,3)
waterfall(xx,yy,zz)
xlabel x,  ylabel y

subplot(2,2,4)
contour(xx,yy,zz)
xlabel x,  ylabel y

