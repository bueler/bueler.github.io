% Gaussian elimination without pivoting to produce L and U factors

n = size(A,1);
Atmp = A;  % save so we keep the original A
L = eye(size(A));
for j = 1:n-1
  for i = j+1:n
    mult = A(i,j) / A(j,j);
    A(i,:) = A(i,:) - mult * A(j,:);
    L(i,j) = mult;
  end
end
U = A;
A = Atmp;
clear Atmp

