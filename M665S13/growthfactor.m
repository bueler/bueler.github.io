% GROWTHFACTOR  Demonstrate that Matlab lu(A) computes huge U on (22.4)

for m = 5
%for m = [1:5 10 20 40 100 200]
  A = tril(-ones(m,m),-1) + eye(m);  A(:,m) = 1;
  [L,U,P] = lu(A);
  A, U
  fprintf('m = %3d:  |A| = %.2e,  |L| = %.2e,  |U| = %.2e,  U(m,m) = %.2f\n',...
          m,norm(A),norm(L),norm(U),U(m,m))
end
