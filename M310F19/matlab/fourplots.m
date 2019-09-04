% FOURPLOTS  Exercise 6 in Chapter 2 of Greenbaum & Chartier.

subplot(2,2,1)
x = -3:.01:3;
plot(x,abs(x-1))
xlabel x

subplot(2,2,2)
x = -4:.01:4;
plot(x,sqrt(abs(x)))
xlabel x

subplot(2,2,3)
plot(x,exp(-x.^2))
xlabel x

subplot(2,2,4)
x = -2:.01:2;
plot(x,1./(10*x.^2+1))
xlabel x

