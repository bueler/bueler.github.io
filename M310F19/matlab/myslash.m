function x = myslash(A,b);
% MYSLASH   Solves a square system of equations  A x = b  using MYLU.
% Works in-place, so this is a "black box" unless you have thought-
% through the issues.
% Example:
%    >> A = randn(5,5);  b = randn(5,1);
%    >> x1 = myslash(A,b)
%    >> x2 = A \ b
%    >> norm(x1 - x2)

n = length(b);
if size(A,1) ~= n || size(A,2) ~= n
    error('A is not n by n, where n is length of b')
end

[p,Z] = mylu(A);

% now solve  L y = P b  by forward substitution
y = zeros(n,1);
y(1) = b(p(1));
for k=2:n
   y(k) = b(p(k)) - Z(p(k),1:k-1) * y(1:k-1,1); % y = L^{-1} P b
end

% back substitution for U x = y
x = zeros(n,1);
x(n) = y(n) / Z(p(n),n); % x is col vector w correct x(n)
for j=n-1:-1:1
   x(j) = (y(j) - Z(p(j),j+1:n) * x(j+1:n)) / Z(p(j),j);
end
