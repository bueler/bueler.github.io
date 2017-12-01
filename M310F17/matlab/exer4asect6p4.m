% EXER4A_SECT6P4  "By hand calculator" session for Exercise 4(a) in section 6.4.

h = 0.25;  t = 0:h:1;  y(1) = 1;
n = 1;  ytmp = y(n) + h * (1+exp(2*t(n))) * y(n);
y(n+1) = y(n) + 0.5 * h * ( (1+exp(2*t(n+1))) * ytmp + (1+exp(2*t(n))) * y(n) );
n = 2;  ytmp = y(n) + h * (1+exp(2*t(n))) * y(n);
y(n+1) = y(n) + 0.5 * h * ( (1+exp(2*t(n+1))) * ytmp + (1+exp(2*t(n))) * y(n) );
n = 3;  ytmp = y(n) + h * (1+exp(2*t(n))) * y(n);
y(n+1) = y(n) + 0.5 * h * ( (1+exp(2*t(n+1))) * ytmp + (1+exp(2*t(n))) * y(n) );
n = 4;  ytmp = y(n) + h * (1+exp(2*t(n))) * y(n);
y(n+1) = y(n) + 0.5 * h * ( (1+exp(2*t(n+1))) * ytmp + (1+exp(2*t(n))) * y(n) );
[t' y']

