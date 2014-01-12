% SHOWFOURIER  efficient way of showing four Fourier series

NN = 20;                        % will show 20 coeffs

x = -pi:pi/500:pi;              % 1000 points in [-pi,pi]
n = (1:NN)';

% f(x) = x^3
figure(1)
c1 = (2 * (-1).^(n+1) ./ n) .* (pi^2 - 6 * n.^(-2));
y = c1' * sin(n*x);
plot(x,y,x,x.^3), xlabel x
legend('Fourier sine series for x^3','x^3')

% f(x) = x^2
figure(2)
c2 = 4 * (-1).^n .* n.^(-2);
y = (pi^2/3) + c2' * cos(n*x);
plot(x,y,x,x.^2), xlabel x
legend('Fourier cosine series for x^2','x^2')

% f(x) = 10 cos(2 x) + 2 sin(10 x)
figure(3)
y = 10 * cos(2 * x) + 2 * sin(10 * x);
plot(x,y), xlabel x
legend('10 cos(2 x) + 2 sin(10 x)')

% show spectrum for all three
figure(4)
set(0,'defaultlinemarkersize',12)
n = [0 n'];
c1 = [0 abs(c1')];
c2 = [pi^2/3 abs(c2')];
c3 = zeros(1,NN+1); c3(3) = 10; c3(11) = 2;
plot(n,c1,'o',n,c2,'*',n,c3,'s')
% alternate plot style:
% semilogy(n,max(c1,1e-4),'o',n,max(c2,1e-4),'*',n,max(c3,1e-4),'s')
axis tight, grid on, xlabel n
legend('f(x)=x^3','f(x)=x^2','f(x)=20 sin(2 x) + 3 sin(11 x)')
title('spectrum of three Fourier series')

