% RUNCN  Demonstrate Crank-Nicolson method in case where exact solution is known.

J = 100;
x = linspace(0,1,J+1);
U0 = sin(2*pi*x);
tf = 0.01;

Ucn = thetaheat(U0, 50,tf,1/2);

subplot(2,1,1),  plot(x,Ucn),  ylabel u

Uexact = exp(-4*pi*pi*tf) * U0;
subplot(2,1,2),  plot(x,abs(Ucn-Uexact)),  xlabel x,  ylabel('error')

