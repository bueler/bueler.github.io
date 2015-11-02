function polycos(m,n);
% Polynomial least squares fit of cos(4t).  Do this for  m  points and
% degree  n-1  polynomial fit:
%     >> polycos(m,n)
% Depends on:  mgs.m,  house.m,  formQ.m

% setup least squares problem
t = linspace(0,1,m);
A = fliplr(vander(t));
A = A(:,1:n);
b = cos(4*t');

% normal equations
fprintf('--------      solving normal equations      --------\n')
xa = (A' * A) \ (A' * b);
fprintf('-------- done with solving normal equations --------\n\n')

% QR by modified Gram-Schmidt
[Q R] = mgs(A);  xb = R \ (Q'*b);
% QR by Householder triangularization
[W R] = house(A);  Q = formQ(W);  xc = R \ (Q'*b);
% QR by built-in
[Q R] = qr(A,0); xd = R \ (Q'*b);
% built-in backslash
xe = A \ b;
% SVD least squares
[U S V] = svd(A,0);  xf = V * (S \ (U' * b));

% show only 9 digits of the first 8 coefficients
X = [xa xb xc xd xe xf];
for j=1:6
   for k=1:8
      fprintf('%13.9f',X(k,j))
   end
   fprintf('\n')
end

