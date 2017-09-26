% EXERCISE3P2N6  Solve Exercise 6 in section 3.2.
f = @(x) 3 - exp(x);
df = @(x) - exp(x);
x0 = [1, 2, 4, 8, 16];
N = 3;
x = x0
for k = 1:N
    for j = 1:length(x)
        x(j) = x(j) - f(x(j)) / df(x(j));
    end
    x
end
