% CLASS28NOV  shows how to use row operations on an augmented
% matrix to solve the system
%   2 x1 +   x2 -   x3 = 3
%     x1 + 5 x2 + 6 x3 = 8
%   4 x1 - 4 x2 +   x3 = 9
% "by-hand", that is, showing each row operation in the
% Gaussian elimination phase, and then showing the 

format rat  % show intermediate results as rational

A = [2 1 -1 3; 1 5 6 8; 4 -4 1 9]  % enter augmented matrix

% Gaussian elimination phase:
% R2 <-- R2 - (1/2) R1
A(2,:) = A(2,:) - (1/2) * A(1,:)
% R3 <-- R3 - (4/2) R1
A(3,:) = A(3,:) - (A(3,1)/A(1,1)) * A(1,:)
% R3 <-- R3 - (-6/(9/2)) R2
A(3,:) = A(3,:) - (A(3,2)/A(2,2)) * A(2,:)

% back-substitution phase:
x(3) = A(3,4) / A(3,3)
x(2) = ( A(2,4) - A(2,3)*x(3) ) / A(2,2)
x(1) = ( A(1,4) - A(1,2)*x(2) - A(1,3)*x(3) ) / A(1,1)

x'  % show result as a column

% use built-in "backslash" method:
A = [2 1 -1; 1 5 6; 4 -4 1];  % enter left-side matrix only
b = [3 8 9]';
X = A \ b

