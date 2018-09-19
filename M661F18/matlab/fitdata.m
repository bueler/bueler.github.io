% FITDATA  Generate figure showing data for problem FIT.

x = 0.0:0.1:1.0;
y = [4.914 3.666 2.289 1.655 1.029 0.739 0.393 0.090 -0.197 -0.721 -0.971];
plot(x,y,'ko','markersize',12.0)
grid on
xlabel('x','fontsize',20.0)
ylabel('y','fontsize',20.0)

print -dpdf fitdata.pdf

