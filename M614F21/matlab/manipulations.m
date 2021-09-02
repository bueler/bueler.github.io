% MANIPULATIONS  Do some manipulations on a matrix by left and right
% matrix multiplications.

% matrix with convenient integer entries
B = magic(4)

% build and apply each factor
L1 = [0 0 1 0; 0 1 0 0; 1 0 0 0; 0 0 0 1];             L1*B
R2 = [1 0 0 0; 0 0 0 1; 0 0 1 0; 0 1 0 0];             L1*B*R2
R3 = eye(4); R3(3,3)=2;                                L1*B*R2*R3
L4 = [1 0 1 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];          L4*L1*B*R2*R3
L5 = [1 -1 0 0; 0 1 0 0; 0 -1 1 0; 0 -1 0 1];    L5*L4*L1*B*R2*R3
R6 = [1 0 0 0; 0 1 0 0; 0 0 0 0; 0 0 1 1];       L5*L4*L1*B*R2*R3*R6
L7 = [0 1 0 0; 0 0 1 0; 0 0 0 1];             L7*L5*L4*L1*B*R2*R3*R6

% print resulting left and right factors
A = L7 * L5 * L4 * L1
C = R2 * R3 * R6
