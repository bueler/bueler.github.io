function f = bumpy(theta,N)
%BUMPY A continuous nowhere-differentiable function.
%                         __
%                        \  | N     S m         m
%            f(theta) =   >        A       cos(A  theta).
%                        /__| m=0
%
% for particular values A,S.  Default N = 100.
% Example on which to zoom in:
%   >> theta = -pi:pi/10000:pi;
%   >> plot(theta,bumpy(theta))

if nargin < 2,  N = 100;  end
A = 4.0;
S = -0.8;
f = zeros(size(theta));
for m = N:-1:0 % loop backward to minimize round-off effects
  k = A^(N-m);
  ak = A^(S*(N-m));
  f = f + ak * cos(k*theta);
end

