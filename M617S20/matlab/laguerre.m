% LAGUERRE  Approximate and plot the first six Laguerre polynomials.

x = (0:.01:10)';
A = [x.^0,x.^1,x.^2,x.^3,x.^4,x.^5];
M = diag(exp(-x/2));
[Q,R] = qr(M*A,0);
L = M \ Q;
L = L*diag(1./L(1,:));
plot(x,L),  xlabel x,  axis([0 10 -14 14]),  grid on
legend('L_0','L_1','L_2','L_3','L_4','L_5')

