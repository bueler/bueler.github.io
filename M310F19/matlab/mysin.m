function z = mysin(x)
% MYSIN  Compute sin(x) for x in radians.  Compare SIN.
% Example:
%   >> mysin(1), sin(1)
%   >> for j=1:9, x=10*randn(1); abs(mysin(x)-sin(x))/abs(sin(x)), end
%   >> mysin(-1.2345e10), sin(-1.2345e10)  % why do these differ so much?

% use symmetries to get y in [0,pi/2]
y = mod(x,2*pi);          % sin(x+2pi) = sin(x);  now  0 <= y < 2*pi
s = 1;
if y > pi
    s = -1;               % sin(y) = -sin(y-pi)
    y = y - pi;
end
if y > pi/2               % sin(y) = sin(pi-y) if 0 <= y <= pi
    y = pi - y;
end

% to regenerate these pre-computed polynomial coefficients:
%   n = 12;
%   x = (pi/4)*(cos(pi*(0:n)/n)+1);
%   p = polyfit(x,sin(x),n);
%   format long e; p'
p = [ 1.46007445427602e-09;
     -3.12306379328951e-08;
      1.55231158855049e-08;
      2.73040663650617e-06;
      2.78764465570937e-08;
     -1.98433634085713e-04;
      1.06331585487319e-08;
      8.33332978513058e-03;
      7.36233935944594e-10;
     -1.66666666752826e-01;
      4.72849417207868e-12;
      9.99999999999922e-01;
     -3.28788169713349e-17];
z = s * polyval(p,y);

