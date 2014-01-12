% TESTMYLU  generate random system and test

m = 10;

% generate and use mylu
A = randn(m,m);
[p,Z] = mylu(A);

% reconstruct matrix factors so that PA=LU
P = eye(m,m);  P = P(p,:);
U = triu(Z(p,:));
L = tril(Z(p,:),-1) + eye(m,m);

% did it work?
norm(P * A - L * U) / norm(A)

% at least in Octave, mylu agrees with built-in lu
[LL,UU,PP] = lu(A);
norm(LL-L)
norm(PP-P)

