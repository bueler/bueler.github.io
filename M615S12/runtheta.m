% RUNTHETA  Demonstrate theta method in case where exact solution is known.

J = 50;  x = linspace(0,1,J+1);  tf = 0.01;
U0 = sin(2*pi*x);

Uexplicit = thetaheat(U0,50,tf,0);
Uimplicit = thetaheat(U0,20,tf,1);

subplot(2,1,1),  plot(x,Uexplicit,x,Uimplicit),  ylabel u
legend('explicit: \theta=0','implicit: \theta=1')

Uexact = exp(-4*pi*pi*tf) * U0;
subplot(2,1,2)
plot(x,abs(Uexplicit-Uexact),'-o',x,abs(Uimplicit-Uexact),'-*')
xlabel x, ylabel('error')
legend('|explicit-exact|','|implicit-exact|')

