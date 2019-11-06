% DEG10FIT   Least-squares fit a degree 10 polynomial to cos(4t).  Solves
% Exercise 14 in Chapter 7 of Greenbaum & Chartier.

m = 50;
n = 11;
t = linspace(0,1,m);
A = fliplr(vander(t));
A = A(:,1:n);           % m x n  matrix 
b = cos(4*t)';          % m x 1  column vector

xa = A \ b;
xb = (A'*A) \ (A'*b);

% clean formatting of coefficients; compare:  >> format long e, [xa xb]
fprintf('  j:   c_j for (a)         c_j for (b)\n')
for j = 1:n
    fprintf('%3d:  %19.15f %19.15f\n',j-1,xa(j),xb(j))
end

