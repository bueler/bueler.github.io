function X = gerrr(A,B)
% GERRR solves A X = B, a linear system with multiple right sides

n = size(A,1);  % n = number of rows
r = size(B,2);  % r = number of right-hand sides

% (naive) Gaussian elimination stage = Alg. 7.1
for col = 1:n-1
  for row = col+1:n
    multiplier = A(row,col) / A(col,col);
    A(row,col) = 0;
    for k = col+1:n
      A(row,k) = A(row,k) - multiplier * A(col,k);
    end
    for p = 1:r
      B(row,p) = B(row,p) - multiplier * B(col,p);
    end
  end
end

% back-substitution stage = Alg. 7.2
X = zeros(n,r);
for p = 1:r
  X(n,p) = B(n,p) / A(n,n);
  for i = n-1:-1:1   % loop through rows backwards
    axsum = A(i,i+1) * X(i+1,p);
    for j = i+2:n
      axsum = axsum + A(i,j) * X(j,p);
    end
    X(i,p) = (B(i,p) - axsum) / A(i,i);
  end
end
