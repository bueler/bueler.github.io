function [Q,D] = jacobi(A,tol,maxsweeps)
% JACOBI  Run the Jacobi iteration on a real symmetric matrix with the goal of
% diagonalizing it.  Returns Q,D so that D is diagonal, Q is orthogonal, and
%   A = Q D Q*
% Expected number of sweeps is about 10.  In that case, does O(m^3) work.
% Reference:  Trefethen & Bau, Lecture 30.
% Example:
%   >> A = randn(5);  A = (A+A')/2;
%   >> [Q,D] = jacobi(A);
%   >> sort(diag(D)), sort(eig(A)),  norm(A - Q*D*Q')

if ~isreal(A),  error('only works for real matrices'),  end
A0 = norm(A,1);
if norm(A-A',1)/A0 > 10*eps,  error('A is not symmetric'),  end
if nargin < 3,  maxsweeps = 20;  end
if nargin < 2,  tol = 1.0e-14;  end

m = size(A,1);
Q = eye(size(A));
for k = 1:maxsweeps
    % measure size of entries strictly above the diagonal
    B = abs(triu(A,1));
    maxB = max(max(B));
    %optional info:   fprintf('  %3d:  offdiag = %.4e\n',k,maxB/A0)
    if maxB/A0 < tol,  break,  end
    % one sweep deals with all entries above diag (i < j)
    for i = 1:m-1
        for j = i+1:m
            % find rotation angle by Tref & Bau formula (30.4)
            theta = 0.5 * atan(2*A(i,j) / (A(j,j) - A(i,i)));
            c = cos(theta);  s = sin(theta);
            % JJ = I  but  JJ([i j],[i j]) = [c s; -s c]
            % compute:  A = JJ' * (A * JJ);
            ai = A(:,i);  aj = A(:,j);
            A(:,i) = c * ai - s * aj;
            A(:,j) = s * ai + c * aj;
            ri = A(i,:);  rj = A(j,:);
            A(i,:) = c * ri - s * rj;
            A(j,:) = s * ri + c * rj;
            % compute:  Q = Q * JJ;
            qi = Q(:,i);  qj = Q(:,j);
            Q(:,i) = c * qi - s * qj;
            Q(:,j) = s * qi + c * qj;
        end
    end
end
if k == maxsweeps
    warning(sprintf('maximum sweeps (= %d) reached',maxsweeps))
end
D = diag(diag(A));

