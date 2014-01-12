function x = gelessnaive(A,b)
% GELESSNAIVE does Gaussian elimination plus back-substitution on your system
%   A x = b
% Also counts and reports arithmetic operations, and the (2/3) n^3 work
% estimate.  This implementation does partial pivoting, and thus has gives
% the standard accuracy.  That is, it is *less naive* than GE.  But of
% course it is just a reimplementation of the built-in method, "A\b",
% and slower.
%
% Example:
%   >> A = [2 1 -1; 1 5 6; 4 -4 1]
%   >> b = [3 8 9]'
%   >> x = gelessnaive(A,b)
%   >> xx = A \ b    % built-in method
% Example 2: solve bigger system to see op. count
%   >> A = randn(100,100);  b = randn(100,1);
%   >> x = gelessnaive(A,b);

n = size(A,1);  % number of rows
if size(A,2) ~= n, error('A is not square'), end
b = b(:);       % make b a column
if length(b) ~= n
  error('b must be a vector of same size as number of rows of A')
end

fprintf('  [flops estimate: (2/3) n^3 = %d]\n',(2/3)*n^3)

% Gaussian elimination with partial-pivoting stage
count = 0;
for col = 1:n-1
  % partial pivoting: find max in your column
  maxsofar = 0;
  mpivot = 0;
  for m = col:n
    if abs(A(m,col)) > maxsofar
      maxsofar = abs(A(m,col));
      mpivot = m;
    end
    if m == n
      if maxsofar == 0, error('no nonzero in column where needed'), end
    end
  end
  % if you get here, A(m,col) ~= 0, so swap rows
  tmp = A(col,:);
  A(col,:) = A(mpivot,:);
  A(mpivot,:) = tmp;
  % and swap b-values:
  btmp = b(col);
  b(col) = b(mpivot);
  b(mpivot) = btmp;
  % now do row operations as usual
  for row = col+1:n
    multiplier = A(row,col) / A(col,col);
    count = count + 1;
    % inner loop below could be done in one line:
    %   A(row,:) = A(row,:) - multiplier * A(col,:);
    %   count = count + 2 * (n+1-col);  % count of ops in prev one line
    A(row,col) = 0;
    for k = col+1:n
      A(row,k) = A(row,k) - multiplier * A(col,k);
      count = count + 2;
    end
    b(row) = b(row) - multiplier * b(col);
    count = count + 2;
  end
end

% back-substitution stage = Alg. 7.2
x = zeros(n,1);
if A(n,n) == 0, error('zero in pivot (diagonal) position [bs stage]'), end
x(n) = b(n) / A(n,n);
count = count + 1;
for i = n-1:-1:1   % loop through rows backwards
  axsum = A(i,i+1) * x(i+1);
  count = count + 1;
  for j = i+2:n
    axsum = axsum + A(i,j) * x(j);
    count = count + 2;
  end
  if A(i,i) == 0, error('zero in pivot (diagonal) position [bs stage]'), end
  x(i) = (b(i) - axsum) / A(i,i);
  count = count + 2;
end

fprintf('  [GELESSNAIVE did %d floating point operations (flops)]\n',count)

