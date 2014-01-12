function [A, b] = genopivot(Ain,bin)
% GENOPIVOT  Implements Gauss elimination, without back-substitution
% or any kind of pivoting, as on page 137 of Greenbaum and Chartier.
% Counts and prints total operation count.
% WARNING: do not use for real computations!  Pivoting is needed and
% you should use "A \ b" anyway!
% Example:
%   >> n = 4;  A = randn(n,n);  x = randn(n,1);  b = A * x;
%   >> [A, b] = genopivot(A,b)
%   >> xx = usolve(A,b);
%   >> norm(xx - x) / norm(x)
% See also: USOLVE, TESTOPCOUNT

n = length(bin);
A = Ain;  b = bin;                         % transfer input to A, b

oc = 0;                                    % initialize operation count
for col = 1:n
  for row = (col+1):n
    mult = A(row,col) / A(col,col);        % THE ONLY DANGEROUS STEP:
                                           %   are we dividing by zero?
    oc = oc + 1;
    A(row,:) = A(row,:) - mult * A(col,:); % an implicit "for" loop
    oc = oc + 2 * (n - col);
    b(row) = b(row) - mult * b(col);
    oc = oc + 2;
  end
end
fprintf('  operation count is %d\n',oc)

