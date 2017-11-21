function euleroscillator(tf,N)
% EULEROSCILLATOR   Use Euler's method to approximate solution of
%   y'' + y = 0,  y(0)=0,  y'(0)=1
% with exact solution y(t) = sin(t).  Problem is converted to:
%   w1' = w2
%   w2' = - w1
% Generates plot of w1 versus t (with exact solution also).
% Usage:   euleroscillator(tf,N)

f = @(t,w) [w(2); - w(1)];
h = tf / N;
t = 0:h:tf;
w = [0; 1];
plot(t(1),w(1),'bo'),  hold on
for j = 1:N
    wnew = w + h * f(t(j),w);
    w = wnew;
    plot(t(j+1),w(1),'bo')
end
plot(t,sin(t),'r')
hold off
legend('w_1','exact y(t)')
xlabel t

