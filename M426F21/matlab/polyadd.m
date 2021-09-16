function r = polyadd(p,q)
% POLYADD Add two polynomials given by row vectors p, q of coefficients
% ordered by decreasing degree.
% Example:
%   >> p = [2 -3 3 1];     % = 2 x^3 - 3 x^2 + 3 x + 1
%   >> q = [4 3 1 0 1];    % = 4 x^4 + 3 x^3 + x^2 + 1
%   >> polyadd(p,q)
%   ans =  4  5  -2  3  2  % = 4 x^4 + 5 x^3 - 2 x^2 + 3 x + 2

% get sizes of inputs
m = length(p);
n = length(q);

% pad the shorter list with zeros
if m < n
  p = [zeros(1, n-m) p];
elseif n > m
  q = [zeros(1, m-n) q];
end

% add them
r = p + q;
