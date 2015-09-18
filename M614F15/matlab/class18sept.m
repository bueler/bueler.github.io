% CLASS18SEPT  Runnable summary of what I showed in class on Friday
% 18 September.

x = randn(3,1)
norm(x)               % same as  norm(x,2)  the p=2 vector norm
sqrt(sum(x'*x))       % same because  x'*y  is inner product of x and y

norm(x,4)             % p=4 vector norm
sum(abs(x).^4)^(1/4)  % same thing

norm(x,'inf')         % p=infinity vector norm
max(abs(x))           % same thing

A = [1 2 3; 4 5 6; 7 8 9]
norm(A)               % p=2 matrix norm
norm(A,1)             % p=1
norm(A,'inf')         % p=infty
norm(A,'fro')         % Frobeniusm matrix norm

%norm(A,4)            % does this even work in Matlab?  not sure how it is
%                     % implemented in Octave

% random estimate of 4-norm:
format long g
NA=0; for j=1:1000, x = randn(3,1); NA = max(NA, norm(A*x,4) / norm(x,4)); end, NA

