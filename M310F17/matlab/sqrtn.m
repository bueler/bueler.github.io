function [z, b, q] = sqrtn(a)
% SQRTN  Compute sqrt(a) by using Newton's method.  Optionally find parts of
% computer representation of a, which is useful for debugging.
% Usage:
%     z = sqrtn(a)
%     [z, b, q] = sqrtn(a)       % get parts of:  a = b 2^q
% Example:
%     >> sqrtn(7)                % same as sqrt(7)

if a < 0
    error('square root is only defined for nonnegative numbers')
elseif a == 0
    z = 0;   b = 0;   q = 0;     % note formulas below will not work in this case
    return
end
q = ceil(log(a) / log(2));       % could be done by grabbing bits in exponent
if mod(q,2) == 1                 % if q is odd, increase by 1
    q = q + 1;
end
b = a / 2^q;                     % should be in [1/4,1]
x = (2 * b + 1) / 3;             % initial iterate from linear interpolation
x = 0.5 * (x + b / x);           % four iterations of Newton seems to get 16 digits
x = 0.5 * (x + b / x);
x = 0.5 * (x + b / x);
x = 0.5 * (x + b / x);
k = q / 2;
z = x * 2^k;                     % could be done by bit manipulations
