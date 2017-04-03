% E2BODY  Compute energies along trajectories

m1 = 5.972e24;  m2 = 7.348e22;  G = 6.674e-11;
E = @(u) 0.5 * m1 * (u(5)^2 + u(6)^2) + 0.5 * m2 * (u(7)^2 + u(8)^2) ...
     - G * m1 * m2 / sqrt((u(1) - u(3))^2 + (u(2) - u(4))^2);
eta = [0; 0; 3.944e8; 0;          % initial positions x1 y1 x2 y2
       0; 0;       0; 1.022e3];   %         velocities v1 w1 v2 w2
E0 = E(eta)                       %         energy

t0 = 0;  secperday = 24 * 60 * 60;  tf = 40.0 * secperday;
N = [40 960];  names = {'FE','RK4'};
for k = 1:2
    for m = 1:2
        if m==1
            [tt,uu]  = forwardeuler(@earthmoon,eta,t0,tf,N(k));
        else
            [tt,uu] = rk4(@earthmoon,eta,t0,tf,N(k));
        end
        Eerr = zeros(1,N(k));
        for n = 1:N(k)+1
           Eerr(n) = abs(E(uu(:,n)) - E0);
        end
        tt = tt/secperday;
        semilogy(tt(2:end),Eerr(2:end)/abs(E0),'k'),  hold on
        text(tt(N(k)/2),Eerr(N(k)/2)/(2*abs(E0)),...
             sprintf('N = %d %s',N(k),names{m}))
    end
end
hold off,  xlabel('t  (days)'),  ylabel('relative energy error')

