function x = myslash(A,b);
% MYSLASH   Solves a square system of equations  A x = b  using MYLU.  Works
% in-place.  These are equivalent for square matrices:
%    >> x = myslash(A,b)
%    >> x = A \ b

m = size(A,1);
if any(size(b) ~= [m 1])
  error('b must be a column vector with same length as a column of A'), end

[p,Z] = mylu(A);

% now solve LU x = P b; forward substitution for L y = P b
y = zeros(m,1);
y(1) = b(p(1));
for k=2:m
   y(k) = b(p(k)) - Z(p(k),1:k-1) * y(1:k-1,1); % y=L^{-1} P b
end

% back substitution for U x = y
x = y;
x(m) = y(m) / Z(p(m),m); % x is col vector w correct x(m)
for j=m-1:-1:1
   x(j) = (y(j) - Z(p(j),j+1:m) * x(j+1:m)) / Z(p(j),j);
end
