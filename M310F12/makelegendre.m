% MAKELEGENDRE  build and plot the first 7 orthogonal Legendre polynomials
% along with the 6 points which give the 6 point Gaussian quadrature
% (i.e. "Gauss-Legendre") rule

x = (-1:.01:1)';
A = [ones(201,1) x x.^2 x.^3 x.^4 x.^5 x.^6];
[Q,R] = qr(A,0);   % equivalent of doing Gram-Schmidt on columns of A
plot(x,Q / diag(Q(end,:)))   % normalizes
grid on, xlabel x
% the legend is a bit cluttered:
%legend('P_0(x)','P_1(x)','P_2(x)','P_3(x)','P_4(x)','P_5(x)','P_6(x)')

hold on
q5 = Q(:,7);
x4 = fzero(@(z) interp1(x,q5,z),[0.1 0.3]); % find the roots of the
x5 = fzero(@(z) interp1(x,q5,z),[0.5 0.8]); %   piecewise-linear interpolant
x6 = fzero(@(z) interp1(x,q5,z),[0.8 1.0]);
xx = [-x6 -x5 -x4 x4 x5 x6]
plot(xx,zeros(size(xx)),'ko','markersize',12)
hold off
