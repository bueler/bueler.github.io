% GEBASIC  Gaussian elimination without pivoting.

for j = 1:n-1                             % loop over columns
    for i = j+1:n                         % loop over rows below j
        mult = A(i,j)/A(j,j);             % subtract this multiple ...
        A(i,:) = A(i,:) - mult * A(j,:);  % does more work than alternative:
                                          %   for k = j+1:n
                                          %       A(i,k) = A(i,k) - mult*A(j,k);
                                          %   end
        b(i) = b(i) - mult * b(j);
    end
end
