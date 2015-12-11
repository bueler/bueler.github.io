function At = mysparse(A)
% MYFULL  Convert conventional form matrix to Bueler's compressed-row
% sparse storage format (BCRSF).  This is merely a *demonstration* of
% sparse storage.  *Very inefficient conversion in this direction.*
% See MYFULL and MYSMATVEC.
% Example:
%   >> A = [3 5 0 0; 7 3 0 0; 0 2 3 1; 0 0 0 3]
%   >> Athing = mysparse(A)
%   >> sparse(A)                  % compare to Matlab's compressed column
%   >> norm(A - myfull(Athing))
% Example 2:
%   >> A = round(0.3*randn(15,10))
%   >> norm(A - myfull(mysparse(A)))

% allocate
[m n] = size(A);
S = 0;
for p=1:m
    for q=1:n
        if A(p,q) ~= 0.0
            S = S + 1;
        end
    end
end
At = { [m n], S, zeros(1,m+S), zeros(1,S)};

% fill
j = 1;
for p=1:m
    k = 0;
    for q=1:n
        if A(p,q) ~= 0.0
            k = k + 1;
            At{3}(j+k) = q;
            At{4}(j-p+k) = A(p,q);
        end
    end
    At{3}(j) = k;
    j = j + k + 1;
end

