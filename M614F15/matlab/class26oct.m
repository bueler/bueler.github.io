% CLASS26OCT  In-class demonstration of least-squares fitting, here with
% a finite Fourier series.  Also look at condition number of Vandermonde
% matrix associated to polynomial fitting.

% input some "data" as column vectors and plot it
x = [0.1 0.3 0.4 0.6 0.8 0.9 1.1]'
y = [1.7 1.2 0.5 0.3 1.2 1.5 1.1]'
figure(1)
plot(x,y,'-o')

% we want
%   y_i = c_1 + c_2 cos(pi x_i) + c_2 cos(2 pi x_i) + c_3 cos(3 pi x_i)
% for  i = 1,...,7,  so build  7 x 4  matrix for this linear system
A = [ones(size(x)) cos(pi*x) cos(2*pi*x) cos(3*pi*x)]

% the columns of A are linearly-independent, which we can see and check
figure(2)
plot(x,A)
rank(A)

% solving in the least squares sense is a built-in "mode" of backslash:
c = A \ y

% plot the least squares solution as a nice curve
xfine = 0:.01:1.2;
p = c(1) + c(2) * cos(pi*xfine) + c(3) * cos(2*pi*xfine) + c(4) * cos(3*pi*xfine);
figure(3)
plot(x,y,'bo',xfine,p,'r-')

% new topic:  why the normal equations might be bad
% answer: the Vandermonde matrix A is already (often) ill-conditioned,
% and the formation of A^* A, when setting-up the normal equations,
% squares the condition number
x = randn(10,1)
A = fliplr(vander(x))
cond(A)
cond(A'*A)

