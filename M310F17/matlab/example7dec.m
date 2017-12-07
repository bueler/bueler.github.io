% EXAMPLE7DEC  Generates an example used in class.

% A will satisfy   P A = L U
P = eye(4);
P = P([2 3 1 4],:);
L = [1 0 0 0; -1/2 1 0 0; 1/2 -1/2 1 0; 1/2 1/2 0 1];
U = [2 3 4 -5; 0 2 -2 3; 0 0 3 -1; 0 0 0 -1];

A = P \ (L*U)
xexact = [1 2 -1 1]';
b = A * xexact

