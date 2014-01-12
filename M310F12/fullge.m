% FULLGE  do all steps of Gauss elimination (but without back-substitution
% or any kind of pivoting)
% n, A, b have to be defined

for col = 1:n
  for row = (col+1):n
    mult = A(row,col) / A(col,col);        % THE ONLY DANGEROUS STEP:
                                           %   are we dividing by zero?
    A(row,:) = A(row,:) - mult * A(col,:); % an implicit "for" loop
    b(row) = b(row) - mult * b(col);
  end
end

% end by showing triangular system in A and b
A,  b

