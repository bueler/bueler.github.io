function [U,c] = gausselim(A,b)
% GAUSSELIM  Naive Gaussian elimination, as in Algorithm 7.1 in
% Epperson 2nd ed.  Returns new system  U x = c  in which U is upper
% triangular.  See BACKSUB to solve that system.
% Example:  Test GAUSSELIM and BACKSUB and compare to backslash.
%   >> A = randn(4,4);  b = randn(4,1);
%   >> [U,c] = gausselim(A,b);
%   >> x = backsup(U,c)
%   >> xx = A \ b
%   >> norm(x-xx)

[n,z] = size(A);
if n ~= z,  error('matrix A must be square'),  end
[p,q] = size(b);
if (p ~= n) | (q ~= 1),  error('vector b must be n-length column'),  end

for i = 1:n-1                    % put zeros in these columns
    for j = i+1:n                % put zeros below diagonal
        if A(i,i) == 0,  error('zero diagonal entry ... stopping'),  end
        m = A(j,i) / A(i,i);     % multiplier for row j
        A(j,i) = 0.0;
        for k = i+1:n
            A(j,k) = A(j,k) - m * A(i,k);
        end
    b(j) = b(j) - m * b(i);
    end
end
U = A;  c = b;

