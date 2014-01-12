function y = lsolve(L, b)
% LSOLVE  Given a lower triangular matrix L with *unit* diagonal
% and a vector b, this routine solves
%    L y = b
% and returns the solution y.
% See also: USOLVE.

n = length(b);                   % determine size of problem
y = zeros(n,1);                  % allocate column of correct size
for i = 1:n                      % loop over equations
  y(i) = b(i);                   % solve for y(i) using
  for j = 1:i-1                  %   previously-computed y(j)
    y(i) = y(i) - L(i,j) * y(j); %   where j < i
  end
end

