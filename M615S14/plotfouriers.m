% PLOTFOURIERS show several Fourier sine approximations to x
% calls FOURIERX

fourierx(1,'b'),  hold on
fourierx(2,'r')
fourierx(3,'g')
fourierx(5,'m')
fourierx(20,'b')
fourierx(50,'r')
x = 0:.002:1;  plot(x,x,'k--')      % dashed black
legend('N=1','N=2','N=3','N=5','N=20','N=50','f(x)=x','location','northwest')
hold off
xlabel x,  ylabel y,  axis tight
title('Fourier sine approximations to f(x)=x')
