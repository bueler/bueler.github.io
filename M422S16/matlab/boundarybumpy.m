% BUMPYBOUNDARY  Surface plot of analytic function on disc with boundary values
% that are the nowhere-differentiable function in BUMPY.  The function is a
% power series
%                         __
%                        \  inf
%                f(z) =   )      a_k z^k
%                        /__k=0
%
% The surface plot shows the real part  u(x,y).  The boundary values
% are a Fourier series:
%                         __
%                        \  inf
%   Re f(e^{i theta}) =   )      a_k cos(k theta)
%                        /__k=0

r = 0:.02:1;
theta = -pi:pi/200:pi;
[RR TH] = meshgrid(r,theta);
ZZ = RR .* exp(i*TH);

A = 4.0;
S = -0.8;

N = 20;
FF = zeros(size(RR));
for m = N:-1:0
  k = A^(N-m);
  ak = A^(S*(N-m));
  % sum  f += a_k z^k  where z = r e^{i theta}
  FF = FF + ak * ZZ.^k;
end

surf(RR.*cos(TH), RR.*sin(TH), real(FF));

%compare plot for sum of  z^k/k:
%surf(RR.*cos(TH), RR.*sin(TH), min(4,-log(abs(1.0-ZZ))));

