function c = mydatafit(x,y)
% MYDATAFIT  Computes the coefficients of a poly p(x)
% of degree  m-1  for m points in x and y.
% Form:
%   c = mydatafit(x,y)
% where
%   x,y = vectors of same length
%   c = vector of coeffs of p(x):
%        p(x) = c(1)  + c(2) x + c(3) x^2 + ... + c(m) x^(m-1)
% Example:  Consider p(x) = 1 + x - x^3.  This should recover
% it:
%   >> x = [1 2 3 4];
%   >> y = [1 -5 -23 -59];
%   >> c = mydatafit(x,y)
% See also: POLYFIT (which does the same thing better!)

% make them both columns (a trick that avoids separate actions
% for rows versus columns)
x = x(:);
y = y(:);

% check data is of same length
m = length(x);
if (m ~= length(y))
  error('inputs x and y must be of same length')
end

% compute the matrix; this is a "Vandermonde matrix"
A = zeros(m,m);  % yes, we should allocate space for clarity
                 % and efficiency, even though the program works
                 % without it
for i = 1:m
  for j = 1:m
    A(i,j) = x(i)^(j-1);  % a_ij = x_i^(j-1)
  end
end

% solve the system
c = A \ y;

end  % <- not essential
