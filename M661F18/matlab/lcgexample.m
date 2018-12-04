% LCGEXAMPLE  Exercise 2.1 in section 13.2 of Griva, Nash, Sofer (2009).
% Demonstrates linear conjugate gradients in a simple example.

A = [2 1 0; 1 2 1; 0 1 2];  b = [1 1 1]';
x0 = zeros(3,1);  r0 = b;

% i=0 iteration (simplified to eliminate p_-1 and beta_0)
p0 = r0;
alpha0 = r0'*r0 / (p0'*A*p0);
x1 = x0 + alpha0 * p0
r1 = r0 - alpha0 * A*p0;

% i=1 iteration
beta1 = r1'*r1 / (r0'*r0);
p1 = r1 + beta1 * p0;
alpha1 = r1'*r1 / (p1'*A*p1);
x2 = x1 + alpha1 * p1

norm(x2 - A\b)   % = 0 because x2 solves Ax=b
p0'*A*p1         % = 0 because p0, p1 conjugate
r0'*r1           % = 0 because r0, r1 orthogonal
