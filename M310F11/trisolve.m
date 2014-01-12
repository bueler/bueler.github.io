function x = trisolve(l,d,u,f)
% TRISOLVE solves the system with left-hand side
%   [ d(1)  u(1)   0     0    ...   0  ]
%   [ l(2)  d(2)  u(2)   0    ...   0  ]
%   [  0    l(3)  d(3)  u(3)  ...   0  ]
%   [  ...          ...            ... ]
%   [  0     0     0    ...  l(n)  d(n)]
% and where f(1), ..., f(n) are the values on the
% right side.  All of l,d,u,f should have length n.
% Importantly, only l(2),...,l(n) are examined.
% Example:
%    >> l = [0 2 1 1];
%    >> d = [6 4 4 6];
%    >> u = [1 1 2 0];
%    >> f = [8 13 22 27];
%    >> x = trisolve(l,d,u,f)

f = f(:);  n = length(f);       % make it a column
if length(l) ~= n, error('input l not of length n'), end
if length(d) ~= n, error('input d not of length n'), end
if length(u) ~= n, error('input u not of length n'), end

for i = 2:n
  mu = l(i) / d(i-1);
  d(i) = d(i) - u(i-1) * mu;
  f(i) = f(i) - f(i-1) * mu;
end

x = zeros(n,1);
x(n) = f(n) / d(n);
for i = n-1:-1:1
  x(i) = (f(i) - u(i) * x(i+1)) / d(i);
end
