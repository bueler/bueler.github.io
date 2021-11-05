% CLASS5NOV  On Friday 11/5 I did a Gaussian elimination introductory
% example.  This code checks the stages using "by-hand in Matlab"
% row operations.  After this we switch to matrix factorization view:
%   Gaussian elimination  =  LU factorization

A = [  1   2   1   2;
      -1   0  -4  -1;
       2   4   0   4;
       1   8 -10   6];
b = [6 -2 12 20]';

% augmented matrix
format short
M = [A b];
disp('doing Gaussian elimination on augmented matrix:')
disp(M)

% stage 1
M(2,:) = M(2,:) - (-1) * M(1,:);
M(3,:) = M(3,:) - ( 2) * M(1,:);
M(4,:) = M(4,:) - ( 1) * M(1,:);
disp('after stage 1:')
disp(M)

% stage 2
M(3,:) = M(3,:) - ( 0) * M(2,:);
M(4,:) = M(4,:) - ( 3) * M(2,:);
disp('after stage 2:')
disp(M)

% stage 3
M(4,:) = M(4,:) - ( 1) * M(3,:);
disp('after stage 3:')
disp(M)

% back-substitution
x = M(:,1:4) \ M(:,5);
disp('after back-substitution:')
x

% checking L1 * A
L1 = eye(4);  L1(2:4,1) = [1 -2 -1]';
L1 * A