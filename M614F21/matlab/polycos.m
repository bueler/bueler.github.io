function polycos(m,n);
% Polynomial least squares fit of cos(4t) on [0,1].
% Usage for  m  points and degree  n-1  polynomial fit:
%     >> polycos(m,n)
% Depends on:  MGS, HOUSE, FORMQ.

% set-up overdetermined system (least squares problem)
t = linspace(0,1,m);
A = fliplr(vander(t));  A = A(:,1:n);
b = cos(4*t');

% normal equations (generate a "singular" warning)
fprintf('--------      solving normal equations      --------\n')
xa = (A' * A) \ (A' * b);
fprintf('-------- done with solving normal equations --------\n')

% reduced QR by modified Gram-Schmidt
[Qhat Rhat] = mgs(A);  xb = Rhat \ (Qhat' * b);

% reduced QR by Householder triangularization
[W Rhat] = house(A);  Q = formQ(W);
Qhat = Q(:,1:n);  xc = Rhat \ (Qhat' * b);

% reduced QR by built-in
[Qhat Rhat] = qr(A,0);  xd = Rhat \ (Qhat'*b);

% built-in backslash
xe = A \ b;

% reduced SVD least squares
[Uhat Shat V] = svd(A,0);  xf = V * (Shat \ (Uhat' * b));

% show 14 digits of the first 10 coefficients
X = [xa xb xc xd xe xf];
for offset = [0 5]
    fprintf('\ncoefficients %d to %d:\n', 1+offset, 5+offset)
    for j=1:6
       for k=1:5
          fprintf('%18.13f',X(k+offset,j))
       end
       fprintf('\n')
    end
end

fprintf('\ncond(A) = %.4e\n', cond(A))
fprintf('cond(A* A) = %.4e\n', cond(A'*A))
