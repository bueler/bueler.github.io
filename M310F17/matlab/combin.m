function z = combin(n,k)
% COMBIN  Compute the number of combinations (ways of choosing) k items out
% of n total:
%                   / n \         n!         n (n-1) ... (n-k+1)
%   combin(n,k)  =  |   |  =  ----------  =  -------------------
%                   \ k /      k! (n-k)!        k (k-1) ... 2
% Does not use the built-in FACTORIAL function.  See also PASCAL10 which uses
% COMBIN to generate part of Pascal's triangle.
% Example:
%   >> combin(6,4)

if (mod(n,1) ~= 0 | mod(k,1) ~= 0)
    error('inputs must be integers')
end
if (n < 0 | k < 0)
    error('inputs must be nonnegative')
end
if (n < k)
    error('n >= k is required')
end

if (n == 0 | k == 0 | k == n)
    z = 1;
else
    z = n / k;
    for j = 1:k-1
        z = z * (n - j) / (k - j);
    end
end
