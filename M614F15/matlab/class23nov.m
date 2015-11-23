% CLASS23NOV  Show Lecture 20, 21, and 22 ideas.

format short g

% compare outputs of built-in lu() on 5x5 matrix; note first "L" is "morally"
% lower triangular, but when we ask for P we get L,U as factors of PA
A = randn(5,5)
[L,U] = lu(A)
[LL,UU,PP] = lu(A)
[norm(A-L*U)  norm(PP*A-LL*UU)]

% conditioning of factors from LU and QR behave quite differently: for LU the
% factors can have worse conditioning than the original matrix; not so for QR
A = randn(50,50);
[L,U,P] = lu(A);
[cond(A) cond(L) cond(U)]
[Q,R] = qr(A);
[cond(A) cond(Q) cond(R)]

% one way to swap rows is to use temporary space:
%A = [2 1 1 0; 4 3 3 1; 8 7 9 5; 6 7 9 8]
%tmp = A(1,:)
%A(1,:) = A(3,:)
%A(3,:) = tmp

% start over and show example from Lecture 21
A = [2 1 1 0; 4 3 3 1; 8 7 9 5; 6 7 9 8]
P1 = [0 0 1 0; 0 1 0 0; 1 0 0 0; 0 0 0 1]      % swap rows 1 and 3
P1*A
L1 = [1 0 0 0; -(4/8) 1 0 0; -(2/8) 0 1 0; -(6/8) 0 0 1]
L1*P1*A
P2 = [1 0 0 0; 0 0 0 1; 0 0 1 0; 0 1 0 0]      % swap rows 2 and 4
P2*L1*P1*A
L2 = [1 0 0 0; 0 1 0 0; 0 -(-0.75/1.75) 1 0; 0 -(-0.5/1.75) 0 1]
L2*P2*L1*P1*A
P3 = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]      % swap rows 3 and 4
P3*L2*P2*L1*P1*A
L3 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 -(ans(4,3)/ans(3,3)) 1]
U = L3*P3*L2*P2*L1*P1*A

% form P in obvious way
P = P3*P2*P1

% form L in much less obvious way (this completes in-class example ...)
L3prime = L3;
L2prime = P3 * L2 / P3;
L1prime = P3 * (P2 * L1 / P2) / P3;
L = inv(L3prime * L2prime * L1prime)

% compare to built-in result; seems to be the same
[LL,UU,PP] = lu(A)

% do Lecture 22 example to show growth factor
A = [1 0 0 1; -1 1 0 1; -1 -1 1 1; -1 -1 -1 1]
L1 = [1 0 0 0; 1 1 0 0; 1 0 1 0; 1 0 0 1];
L2 = [1 0 0 0; 0 1 0 0; 0 1 1 0; 0 1 0 1];
L3 = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 1 1];
U = L3*L2*L1*A

% again compare condition numbers
[cond(A) cond(L) cond(U)]
[Q,R] = qr(A);
[cond(A) cond(Q) cond(R)]

