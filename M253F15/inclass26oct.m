% INCLASS26OCT  Edited version of my Matlab/Octave demo in-class in
% Math 253 on 26 October.  The following works in *either* Matlab or
% Octave.  You can type-in the below commands, or run this as a program
% (a "script").  Note everything after "%" is a "comment" which
% Matlab/Octave will ignor.

% this shows how to plot  y = sin(x)  a la calculus I
x = 0:.01:5;
figure(1)
plot(x,sin(x))

% this shows how to generate a contour plot of
%     f(x,y) = 2 x^2 - 4 x y + y^4 + x - y
% on a rectangular domain which we choose
[x,y] = meshgrid(-5:.1:5,-5:.1:5);    % generates lots of numbers
figure(2)
contour(x,y,2*x.^2-4*x.*y+y.^4+x-y)   % let Matlab/Octave choose contour levels

% reduce rectangle and choose and label our levels:
[x,y] = meshgrid(-2:.1:2,-2:.1:2);
figure(3)
h = contour(x,y,2*x.^2-4*x.*y+y.^4+x-y,[-2 -1 0 1 2 3 4]);   % output h is a "handle" for the contours
clabel(h)

