function A = polymat(x,y)
% POLYMAT  Build a polynomial interpolation matrix A.  Note use of
% assert() for minimal error checking.
% Example:
%   >> n = 5;  x = linspace(-1,1,n);
%   >> m = 27;  y = linspace(-1,1,m);
%   >> A = polymat(x,y);

n = length(x);
assert(length(y) >= n)
B = fliplr(vander(x));
C = fliplr(vander(y));
C = C(:,1:n);
A = C / B;
