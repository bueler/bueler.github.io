f = @(x) exp(x) - sqrt(4 - x^2);
a = 0;
b = 2;
for j = 1:50
    c = (a + b) / 2;
    if f(c) < 0
        a = c;
    else
        b = c;
    end
end
c

