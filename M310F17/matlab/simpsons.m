function z = simpsons(f,a,b,n)
% SIMPSONS  Simpson's rule on the final exam.
if mod(n,2) == 1,  error('n must be even'),  end
h = (b-a)/n;
x = a:h:b;
z = f(x(1)) + f(x(n+1));
for k = 2:2:n
   z = z + 4 * f(x(k));
end
for k = 3:2:n-1
   z = z + 2 * f(x(k));
end
z = (h/3) * z;
