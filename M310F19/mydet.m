function z = mydet(A)
% MYDET A very dangerous way to compute determinants is to do it recursively
% *the way you were taught to do it by hand*.  That's what MYDET does!
% Example:  >> A = randn(5,5);
%           >> mydet(A),  det(A)
% WARNING:  * Not suitable for matrices bigger than 10x10!
%           * Always use built-in det() for determinants.  This code is *orders
%             of magnitude* slower if n >= 5.
% WARNING:  To determine if a matrix is invertible use cond() or condest().

n = size(A,1);
if size(A,2) ~= n,  error('only works on square matrices'),  end

if n == 1
    z = A(1,1);
elseif n == 2
    z = A(1,1)*A(2,2) - A(1,2)*A(2,1);
else
    z = 0;
    for j = 1:n
        Aminor = A(2:n,[1:j-1, j+1:n]);
        z = z + (-1)^(j-1) * A(1,j) * mydet(Aminor);
    end
end

