function x = usolve(U, y)
% USOLVE  Given a upper triangular matrix U with nonzero diagonal
% and a vector y, this routine solves
%    U x = y
% and returns the solution x.
% Counts and prints total operation count.
% See also: LSOLVE.

n = length(y);                   % determine size of problem
x = zeros(n,1);                  % allocate column of correct size
oc = 0;                          % initialize operation count
for i = n:-1:1                   % loop over equations
  x(i) = y(i);                   % solve for x(i) using
  for j = i+1:n                  %   previously-computed x(j)
    x(i) = x(i) - U(i,j) * x(j); %   where j > i
    oc = oc + 2;
  end
  if U(i,i) == 0, error('zero on diagonal'), end
  x(i) = x(i) / U(i,i);          % divide by diagonal entry
  oc = oc + 1;
end
fprintf('  operation count is %d\n',oc)

