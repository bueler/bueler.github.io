% GENPOROUSERRFIG   show error from a couple of runs of POROUS

x21 = linspace(-10,10,21);
Uerr21 = porous(x21,0.1,10);
x101 = linspace(-10,10,101);
Uerr101 = porous(x101,0.1,10);
figure, clf
plot(x21,Uerr21,'ko',x101,Uerr101,'k*')
legend('J=20','J=100')
xlabel x
ylabel('error  |U-uexact|')
