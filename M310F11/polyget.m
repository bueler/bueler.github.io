function z = polyget(n,x,y,xx)
% POLYGET  Compute the value of the polynomial interpolant at the
% given point:
%     z = p(xx)
% where  p  is a degree  n  polynomial which goes through points
% given in lists x,y.  These lists must have length n+1.
%
% Speed:  Does  2 n^2 + 4 n  flops.
%
% Example.  Generate random polynomial and evaluate it:
%   >> format long
%   >> x=randn(1,7);  y = randn(1,7);  xx = 1;  
%   >> polyget(6,x,y,xx)
%   >> polyval(polyfit(x,y,6),xx)   % compare to built-in poly... pair

if length(x) ~= n+1, error('x must be a vector of length n+1'), end
if length(y) ~= n+1, error('y must be a vector of length n+1'), end

a = zeros(size(x));         % space for coefficients a(1),...,a(n+1)

% Algorithm 4.1:  get coefficients for Newton form of p
a(1) = y(1);
for k = 2:n+1
  w = 1;
  p = 0;
  for j = 1:k-1
    p = p + a(j) * w;
    w = w * (x(k) - x(j));
  end
  a(k) = (y(k) - p) / w;
end

% Algorithm 4.2 = Horner:  evaluate polynomial p at xx
z = a(n+1);
for k = n:-1:1
  z = a(k) + (xx - x(k)) * z;
end
