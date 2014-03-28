function Mmat = formM(Jx,Jy);
% FORMM  Assembles (Jx+1) x (Jy+1) array of zeros and ones which looks like the
% capital letter "M" as on pages 68-69 of Morton & Mayers 2nd ed.

Mmat = ones(Jx+1,Jy+1);

x = linspace(0,1,Jx+1);
y = linspace(0,1,Jy+1);
[xx,yy] = ndgrid(x,y); % so we can refer to point in block by (x,y) in [0,1]x[0,1]

% block out
Mmat(xx<0.2) = 0.0;
Mmat(xx>0.8) = 0.0;
Mmat(yy<0.2) = 0.0;
Mmat(yy>0.8) = 0.0;

% cut out block on bottom
Mmat((xx>0.3)&(xx<0.7)&(yy<0.4)) = 0.0;

% notch top
zz1 = -(10/7)*xx - (4/7)*yy + 1;  % zz1 = 0 is line through (0.3,1.0) and (0.5,0.5)
zz2 = -(10/3)*xx + (4/3)*yy + 1;  % zz2 = 0 is line through (0.7,1.0) and (0.5,0.5)
Mmat((zz1<0.0)&(zz2>0.0)) = 0.0;

% bottom notches (bit of trial and error needed)
Mmat((xx<0.7)&(zz2<-0.4)) = 0.0;
Mmat((xx>0.3)&(zz1>(3/7)*0.4)) = 0.0;

% show; note transpose is needed to give correct meaning to x,y axes
Mmat = Mmat';
mesh(Mmat), xlabel x, ylabel y, axis off

