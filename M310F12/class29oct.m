% CLASS29OCT  what I did in class

% demonstrate firstlu.m
A = randn(4,4)
firstlu
whos
L
U
L * U
L * U - A
norm(L * U - A)
norm(L * U - A) / norm(A)  % this number is small so we succeeded

% note errors grow more slowly (with n) than does amount of work
A = randn(4,4); firstlu; norm(L*U-A)/norm(A)
A = randn(40,40); firstlu; norm(L*U-A)/norm(A)
A = randn(400,400); firstlu; norm(L*U-A)/norm(A)

% demonstrate how max produces two outputs (see inside mylu.m)
[x,y] = max([2 4 3 9 4])

% demonstrate in-place partial-pivoting LU by mylu.m
A = magic(4)
format short g
[p, Z] = mylu(A)  % output Z is a mess
                  % output p shows permutation

% recover parts
P = eye(4,4);  P = P(p,:)
U = triu(Z(p,:))
L = tril(Z(p,:),-1) + diag(ones(4,1))

% check that PA = LU
norm(P*A - L*U)/norm(A)

% check more cases
m = 50;  A = randn(m,m);  [p,Z] = mylu(A);  P = eye(m,m);  P = P(p,:);  U = triu(Z(p,:));  L = tril(Z(p,:),-1) + diag(ones(m,1));  norm(P*A-L*U)/norm(A)

m = 500;  A = randn(m,m);  [p,Z] = mylu(A);  P = eye(m,m);  P = P(p,:);  U = triu(Z(p,:));  L = tril(Z(p,:),-1) + diag(ones(m,1));  norm(P*A-L*U)/norm(A)

