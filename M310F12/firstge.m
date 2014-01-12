% Gaussian elimination without pivoting.
% See page 137 of Greenbaum & Chartier.

for j = 1:n-1
  for i = j+1:n
    mult = A(i,j) / A(j,j);
    A(i,:) = A(i,:) - mult * A(j,:);
    b(i) = b(i) - mult * b(j);
  end
end

