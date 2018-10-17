function kleeminty(n)
% KLEEMINTY  A famous bad example of a linear programming problem where
% the simplex method becomes as slow as a brute-force tour of the extreme
% points.  See wikipedia page for "Klee-Minty cube".
% Usage:   kleeminty(n)
% where:
%          n = dimension; defaults to n = 4.
% Requires: MYSIMPLEX

if nargin < 1,  n = 4;  end

% set up problem
c = -2.^(n-1:-1:0)';
A = eye(n,n);
for k = 2:n
   A(k,1:k-1) = 2.^(k:-1:2);
end
b = 5.^(1:n)';

% show
fprintf('Klee-Minty cube in dimension %d:\n',n)
disp('c'' =')
disp(c')
disp('A =')
disp(A)
disp('b'' =')
disp(b')

% call simplex method
%[x, z] = mysimplex(c,A,b)             % <--- form to use if your mysimplex.m
                                       %      only takes three arguments
[x, z] = mysimplex(c,A,b,true,2^n+1)   % show iterations and raise maxiter
                                       % to a sufficient number

