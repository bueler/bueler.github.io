% CLASS5OCT  Show that one can recover SVD from eig(A) in case A is hermitian.

% a hermitian matrix and its eigenvalues and singular values
A = [3 1 2; 1 2 1; 2 1 -2]
eig(A)
svd(A)                       % note: = abs of eigenvalues, but reordered

% this is what we want to "match"
[U,Sigma,V] = svd(A);
norm(U*Sigma*V' - A)         % check it is an SVD

% get eigenvectors in first output argument and eigenvalues in second
[Q,Lambda] = eig(A);
norm(Q'*Q - eye(3))          % check Q is unitary

% note ordering of eigenvalues; generate permutation:
P = [0 0 1; 1 0 0; 0 1 0]' 
SigmaSigma =P'*abs(Lambda)*P % note this is same as Sigma

% use ideas from Lecture 5 to re-generate U and V
UU = Q*P
VV = (P'*sign(Lambda)*Q')'
norm(UU*SigmaSigma*VV' - A)  % check it is an SVD

% note unitary matrices are NOT equal; SVD is not unique
norm(U-UU)
norm(V-VV)

