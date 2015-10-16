% CLASS16OCT  Analogy between QR on matrices A and Gram-Schmidt
% on monomials to compute Legendre polynomials.  See Experiment #1
% in Lecture 9 of Trefethen & Bau.

% the interval [-1,1] represented as a vector in dimension 201
x = (-1:.01:1)';

% manually generate monomials, and plot them
a1 = ones(201,1);
a1 = ones(size(x));
a2 = x;
a3 = x.^2;
a4 = x.^3;
figure(1), clf
subplot(2,1,1)
plot(x,a1,x,a2,x,a3,x,a4),  axis tight
title('monomials')

% again, more efficiently
A = [ones(size(x)) x x.^2 x.^3];
% size(A)  is 201 x 4
subplot(2,1,2)
plot(x,A),  axis tight

% to check if "A=QR" requires computing relative error *if* entries
% of A are really big
B = 10^16 * A;           % entries ARE big now
[Q R] = qr(B,0);
norm(B - Q*R)            % not apparently small ...
norm(B - Q*R)/norm(B)    %   ... but it was small in a relative sense

% orthogonalize columns of A, check, and plot cols of Q
[Q R] = qr(A,0);
norm(A - Q*R)/norm(A)
figure(2), clf
subplot(2,1,1)
plot(x,Q),  axis tight
title('Legendre polynomials (different normalizations)')

% scale our orthogonal polynomials so that  q_j(1) = 1
Qscale = Q * diag(1./Q(end,:));
subplot(2,1,2)
plot(x,Qscale),  axis tight

% switch from polynomials to sines and cosines a la Fourier
A = [ones(size(x)) sin(pi*x) cos(pi*x) sin(2*pi*x) cos(2*pi*x)];
[Q R] = qr(A,0);
figure(3), clf
subplot(2,1,1)
plot(x,A),  axis tight
title('sines and cosines (different normalizations)')
subplot(2,1,2)
plot(x,Q),  axis tight

% matrix R is nearly diagonal because our discrete sines and cosines
% are nearly orthogonal; improve this by paying attention to how well
% vector inner product approximates an integral
format short g
R
figure(4), clf
imagesc(R),  colormap gray
