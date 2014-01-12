% PROBLEM104 find x0, x1 so that
%   /1
%   |  x f(x) dx = A0 f(x0) + A1 f(x1)
%   /0
% is exact for f(x) = (polynomial of degree 3 or less)

% METHOD 1:  by hand I derived this equation
%   a x0^2 + b x0 + c = 0
% where  a = (1/8)-(1/9),  b = (1/12) - (1/10),  c = (1/15) - (1/16)
% so this finds the roots:
x = roots([(1/8 - 1/9), (1/12 - 1/10), (1/15 - 1/16)]);
x = sort(x)

% METHOD 2:  find the roots of a degree 2 polynomial q(x) for which
%   /1
%   |  x q(x) p(x) dx = 0
%   /0
% if p(x) is degree zero or 1 (use the built-in "Gram-Schmidt"
% orthogonalizer, namely "qr") and then find the roots of q(x)
% note we need guesses about the roots but I got those by
% plotting Q(:,3); this method only gives a couple of digits of accuracy
xx = (0:0.0002:1)';
A = [sqrt(xx) xx.*sqrt(xx) xx.^2.*sqrt(xx)];
Q = qr(A,0);
xqr = [fzero(@(z) interp1(xx,Q(:,3),z),0.4);
       fzero(@(z) interp1(xx,Q(:,3),z),0.8)]

% now show that it is as exact as stated
x0 = x(1);  x1 = x(2);
A1 = ((1/2)*x0 - (1/3)) / (x0-x1);
A0 = (1/2) - A1;
exactint = [(1/2) (1/3) (1/4) (1/5)];
numint = [(A0+A1) (A0*x0+A1*x1) (A0*x0^2+A1*x1^2) (A0*x0^3+A1*x1^3)];
% this number should be about 1e-15 or less:
norm(numint-exactint) / norm(exactint)

