% CLOSETPOLYS  Solution to P6 on Assignment #6.

% part (a)
t = [0 1 2 2.9 3 3.01 4];
V = fliplr(vander(t));
cond(V)

% part (b)
W = V(:,1:3);
cond(W)
cond(W'*W)

% part (c)
y = sin(t) + 0.01 * randn(size(t));
ca = polyfit(t,y,6);
cb = polyfit(t,y,2);
tt = -0.1:.001:4.1;
plot(t,y,'o',tt,polyval(ca,tt),tt,polyval(cb,tt),tt,sin(tt))
legend('data','degree 6 interpolant','degree 2 least-squares fit','y=sin(t)')
axis tight,  grid on,  axis([-0.1,4.1,-7,7])

print -dpdf closetpolys.pdf
