% SVDCURVEMAT

M = curvemat;
% rank(M)

[U S V] = svd(M);
sigma=diag(S);
% sigma(1:22)

S9 = S;   S9(S<6)=0;   rank(S9)
S21 = S;  S21(S<4)=0;  rank(S21)
S46 = S;  S46(S<2)=0;  rank(S46)

close all
figure(1), imagesc(M), colormap bone, title('M has rank 111')
figure(2), imagesc(U*S9*V'), colormap bone, title('rank 9 approx to M')
figure(3), imagesc(U*S21*V'), colormap bone, title('rank 21 approx to M')
figure(4), imagesc(U*S46*V'), colormap bone, title('rank 46 approx to M')

