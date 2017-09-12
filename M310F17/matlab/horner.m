function [p, dp] = horner(a,x)
% HORNER Evaluate a polynomial of degree n, and its derivative.  The input is
% a list (array)  a  of n+1 coefficients:
%   p(x) = a(1) + a(2) x + a(3) x^2 + ... + a(n+1) x^n
% Uses Horner's rule to reduce the number of operations:
%   p(x) = a(1) + x (a(2) + x (a(3) + ... + a(n+1)*x) ... )
% Example:  To evaluate p(x)=x^3+3x+2 and p'(x)=3x^2+3 at x=4 do
%   >> [p,dp] = horner([2 3 0 1],4)
%   p =  78
%   dp =  51
% Note asking for one output gives the first only:
%   >> p = horner([2 3 0 1],4)
%   p =  78
% See also: POLYVAL

n  = length(a) - 1;
p  = a(n+1);
dp = n * a(n+1);
for k = n:-1:1
    p  = a(k) + x * p;
    if k > 1
        dp = (k-1) * a(k) + x * dp;
    end
end
