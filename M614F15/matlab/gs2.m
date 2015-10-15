function z = gs2(A,b,x0,N)
% GS2  Do N steps of Gauss-Seidel iteration.  Implemented using for loops.
% Usage:
%   >> z = gs2(A,b,x0,N)

z = x0;
m = length(z);
for k = 1:N
  for i = 1:m
    z(i) = b(i);
    for j = i+1:m
      z(i) = z(i) - A(i,j) * z(j);
    end
    for j = 1:i-1
      z(i) = z(i) - A(i,j) * z(j);
    end
    z(i) = z(i) / A(i,i);
  end
end
