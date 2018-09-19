% CALCONE_BRUTE  Find min of calculus I function by brute force: generate
% millions of values and select smallest.

f = @(x) (x.^2 + cos(x)).^2 - 10.0 * sin(5.0 * x);

N = 2*10^6 + 1;
x = linspace(0.0,2.0,N);
y = f(x);                    % does a lot of arithmetic!!

j = 1;
for k = 2:N
    if y(k) < y(j)
        j = k;
    end
end
x(j)
