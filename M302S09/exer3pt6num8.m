% solve exercise 3.6 #8 using improved Euler:
%  y' = (1/x) (y^2 + y),  y(1) = 1

h = 0.2;
x = [1.0 1.2 1.4 1.6 1.8];
y = [1.0   0   0   0   0];  % space for solution, and set initial condition
yE = y;

for n=1:4
  % see equation (9) in 3.6:
  fn = (1.0/x(n)) * (y(n)^2 + y(n));
  ynp = y(n) + h * fn;
  fnp = (1.0/x(n+1)) * (ynp^2 + ynp);
  y(n+1) = y(n) + (h/2) * (fn + fnp);

  % do Euler for comparison
  yE(n+1) = yE(n) + h * (1.0/x(n)) * (yE(n)^2 + yE(n));
end

yexact = x./(2-x);  % equation is separable, so compare to exact

plot(x,y,'o-',x,yE,'*-',x,x./(2-x),'x-')
legend("improved Euler","Euler","exact")

x,y,yE,yexact  % just show numbers
