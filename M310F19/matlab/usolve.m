function x = usolve(U,y)
% USOLVE  Given an upper triangular matrix U and a vector y this routine
% solves  U x = y  and returns the solution x.

n = length(y);
if size(U,1) ~= n || size(U,2) ~= n
    error('U must be n by n if y has length n')
end

x = zeros(n,1);                    % allocate space for answer
x(n) = y(n) / U(n,n);              % get started outside the loop
for i = n-1:-1:1                   % count down
    s = y(i);                      % build up the sum ...
    for j = i+1:n
        s = s - U(i,j) * x(j);     % note these x(j) are already known
    end
    x(i) = s / U(i,i);             % ... finally divide
end
