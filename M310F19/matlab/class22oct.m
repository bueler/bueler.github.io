% CLASS22OCT   Solve polynomial interpolation and least squares fit problems.

x = rand(1,6);
y = randn(1,6)'
plot(x,y,'o');

format short g
A = fliplr(vander(x))

c = A\y

xfine = 0:.001:1;
figure(1)
plot(x,y,'o',xfine,c(1)+c(2)*xfine+c(3)*xfine.^2+c(4)*xfine.^3+c(5)*xfine.^4+c(6)*xfine.^5)
axis([0 1 -2 2])

p = polyfit(x,y',5)
figure(2)
plot(x,y,'o',xfine,polyval(p,xfine))

figure(3)
plot(x,y,'o',xfine,polyval(flipud(c),xfine))

x = [1 2 3 5 7];
y = [2 3 0 -1 1]';
A = fliplr(vander(x));
A = A(:,1:3)
c = A \ y
xfine = 0:.01:8;
figure(4)
plot(x,y,'o',xfine,c(1)+c(2)*xfine+c(3)*xfine.^2)

cnew = (A'*A) \ (A'*y)
norm(c-cnew)

cthird = polyfit(x,y',2)
norm(c-flipud(cthird'))

cond(A)
cond(A'*A)
sqrt(ans)

