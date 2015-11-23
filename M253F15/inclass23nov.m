% INCLASS23NOV  Use Matlab/Octave to visualize some vector fields.

% first example: 2D vector field  F(x,y) = -y ihat + x jhat
[xx,yy] = meshgrid(-2:.5:2,-2:.5:2);   % a grid of 9x9 = 81 points
P = -yy;  Q = xx;
figure(1),  quiver(xx,yy,P,Q)
xlabel x,  ylabel y

% second example: 3D vector field   F(x,y,z) = - (x ihat + y jhat + z khat) / sqrt(x^2+y^2+z^2)
[xx,yy,zz] = meshgrid(-1:.4:1,-1:.4:1,-1:.4:1);   % a grid of 6x6x6 = 216 points
rho = sqrt(xx.^2 + yy.^2 + zz.^2);
P = - xx ./ rho;  Q = - yy ./ rho;  R = - zz ./ rho;  
figure(2),  quiver3(xx,yy,zz,P,Q,R)
xlabel x,  ylabel y,  zlabel z

% for figure 2, see the effect of these commands:
%view(2)
%view(3)
%view(45,0)
%for j=0:240, view(j*360/120,15), pause(0.1), end

