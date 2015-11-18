% AVTEMP  Compute average temperature of a made-up room.
% Uses midpoint rule on mesh of 1-cubic-foot blocks.
% Also try entering the following into Wolfram Alpha:
%   "(integrate 70 - 0.1 ((x-15)^2+(y-10)^2+(z-5)^2) from x=0 to x=30 and y=0 to y=20 and z=0 to z=10)/6000"
% generated answer 58 1/3.

%Nx = 30;   Ny = 20;   Nz = 10;   % each dV is one cubic foot
Nx = 360;  Ny = 240;  Nz = 120;  % each dV is one cubic inch;  WARNING: takes much more than a minute

f = @(x,y,z) 70 - 0.1 * ((x-15)^2 + (y-10)^2 + (z-5)^2);

dx = 30/Nx;  dy = 20/Ny;  dz = 10/Nz;
s = 0;  % this is the running sum
for i = 1:Nx
  x = (i - 1/2) * dx;
  for j = 1:Ny
    y = (j - 1/2) * dy;
    for k = 1:Nz
      z = (k - 1/2) * dz;
      s = s + f(x,y,z);
    end
  end
end

s / (Nx * Ny * Nz)
