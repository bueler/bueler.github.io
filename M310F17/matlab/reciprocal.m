function [z, s, b, q] = reciprocal(a)
% RECIPROCAL  Compute 1/a by using Newton's method.  Optionally find parts of
% computer representation of a, which is useful for debugging.
% Usage:
%     z = reciprocal(a)
%     [z, s, b, q] = reciprocal(a)    % get parts of  a = (+-1) b 2^q
% Example:
%     >> reciprocal(7)      % same as 1/7

if a == 0
    error('1/a only defined for a nonzero')
end
s = sign(a);                     % grab the sign bit
a = abs(a);
q = ceil(log(a) / log(2));       % could be done by grabbing bits in exponent
b = a / 2^q;                     % should be in [1/2,1]
x = 3 - 2 * b;                   % initial iterate from linear interpolation
x = x * (2 - b * x);             % four iterations of Newton seems to get 15 digits
x = x * (2 - b * x);
x = x * (2 - b * x);
x = x * (2 - b * x);
z = s * x / 2^q;                 % dividing by 2^q could be done by flipping a bit
                                 % in the exponent of original a
