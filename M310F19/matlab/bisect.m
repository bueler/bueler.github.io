% BISECT our code

n = 50;
a = 0;
b = 1;

for i = 1:n
    c = (a+b)/2;
    fa = a^3-7*a+2;
    fc = c^3-7*c+2;
    if fa*fc < 0
        b = c;
    else
        a = c;
    end
end
a,b

