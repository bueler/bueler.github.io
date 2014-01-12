% STEPONEGE  do first column of gauss elimination on system A x = b
% n, A, b have to be defined

for row = 2:n
  mult = A(row,1) / A(1,1)
  A(row,:) = A(row,:) - mult * A(1,:)
  b(row) = b(row) - mult * b(1)
end

% show system
A,b
