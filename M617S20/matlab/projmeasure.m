function [P, Qh] = projmeasure(A,rect);
% PROJMEASURE  Given a square, n x n, normal matrix A, implements a
% projector-valued "measure" on the complex plane, for rectangular
% regions.
%   First generates a plot of the eigenvalues in the complex plane.
% With one input argument and one output argument,
%    P = projmeasure(A)
% ask user to use the mouse to mark the upper-left and lower-right
% corners of a rectangle containing eigenvalues of interest.  The
% resulting projector P is the same size as A but projects onto the
% span of the eigenvectors for eigenvalues in the rectangle.  In
% general it takes 2 input and 2 output arguments.  The second input
% is the rectangle and the second output argument is matrix Qh
% formed from the (orthonormal) eigenvectors:
%    [P, Qh] = projmeasure(A,rect)
% Note Qh has m <= n columns which span the invariant subspace
% and P = Qh * Qh' is the corresponding orthogonal projector.
% Example 1:
%   >> A = gennormal(100);
%   >> P = projmeasure(A);   % <-- user input with mouse
%   >> rank(P)               % = number of selected eigenvalues
% Example 2:
%   >> A = gennormal(100);   % note norm(A)<10 with very high probability
%   >> P = projmeasure(A,[0 10 -10 10]);  % for right half-plane
% Example 3:
%   >> A = expm(i*gennormal(100));
%   >> [Qh,P] = projmeasure(A);   % <-- choose m (e.g. m=5) eigs with mouse
%   >> B = Qh'*A*Qh;              % m x m diagonal matrix
%   >> lB = eig(B);  plot(real(lB),imag(lB),'o')  % ... has same eigs
% See also GENNORMAL, GENHERM.

% A must be square
[m n] = size(A);
if m ~= n,  error('input matrix A must be square'),  end

% determine if A is hermitian, warn if A is not normal
herm = false;
nA1 = norm(A,1);   % 1-norm much faster than 2-norm
tol = 1.0e-10 * nA1;
if norm(A-A',1) < tol
    herm = true;
    fprintf('hermitian ')
else
    if norm(A*A'-A'*A,1) > tol*nA1
        warning('matrix A is NOT normal; P will not be orthogonal projection!')
    end
end
fprintf('matrix A is %d x %d ...\n',m,n)

% compute eigenvalues by dense O(n^3) method
fprintf('computing eigenvalues ...\n')
[X,lam] = eig(A,'vector');
lam = lam';

% try to plot eigenvalues with tolerable scaling
plot(real(lam),imag(lam),'bo')
pb = [min(real(lam)), max(real(lam)), min(imag(lam)), max(imag(lam))];
sc = max(abs(lam))/2;
if herm
    axis([pb(1)-sc pb(2)+sc -1.0 1.0])
else
    th = 0:.01:2*pi;
    hold on,  plot(cos(th),sin(th),'g'),  hold off   % plot unit circle
    pb = [min([-1.1 pb(1)-sc]),max([1.1 pb(2)+sc]),...
          min([-1.1 pb(3)-sc]),max([1.1 pb(4)+sc])];
    axis(pb)
    axis equal
end
grid on
xlabel('Re(lambda)')
ylabel('Im(lambda)')
title('spectrum of A (eigenvalues) in complex plane')

% get and plot rectangle containing spectrum of interest
hold on
if nargin < 2
    fprintf('please USE MOUSE to indicate NW and SE corners of rectangle ...\n')
    [x0,y0] = ginput(1);
    plot(x0,y0,'r*','markersize',10)
    [x1,y1] = ginput(1);
    plot(x1,y1,'r*','markersize',10)
    rect = [x0,x1,y1,y0];
end
plot([rect(1) rect(2) rect(2) rect(1) rect(1)],...
     [rect(3) rect(3) rect(4) rect(4) rect(3)],'r--')
hold off
fprintf('rectangle to measure (generate projection):\n')
fprintf('    %6.4f <= Re(lambda) <= %6.4f,  %6.4f <= Im(lambda) <= %6.4f\n',...
        rect(1),rect(2),rect(3),rect(4))

% find indices of eigenvalues in rectangle
idx = find(real(lam) >= rect(1)-tol & real(lam) <= rect(2)+tol ...
           & imag(lam) >= rect(3)-tol & imag(lam) <= rect(4)+tol);
m = sum(idx > 0);
fprintf('%d eigenvalues selected ... \n',m)

% put corresponding eigenvectors in Qh and form P
fprintf('computing Qh and projection P ...\n')
Qh = X(:,idx);    % n x m (not square) matrix
P = Qh * Qh';     % n x n matrix; same size as A

