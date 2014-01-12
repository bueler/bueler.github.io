% BISECTP1   Solve x^2 = e^-x by bisection.

a = 0;  b = 1;               
for n=1:13
  x = (a+b)/2;  f = x^2 - exp(-x);
  if f < 0                          % so f(x) has same sign as f(a)
    a = x;
  else
    b = x;
  end
end
x
