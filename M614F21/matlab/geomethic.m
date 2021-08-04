function z = geomethic(x)
% GEOMETHIC https://xkcd.com/2435/
% Example:
%   >> x = [1 1 2 3 5];
%   >> for k = 1:20,  x = geomethic(x);  end,  x

assert(all(isreal(x)))
assert(all(x>0))
z = zeros(3,1);
n = length(x);
z(1) = mean(x);
z(2) = prod(x).^(1/n);
z(3) = median(x);