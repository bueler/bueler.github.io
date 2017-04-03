% TWOBODY  Solve Earth-Moon problem by comparing forward Euler and RK4 solutions
% of system of 8 first-order ODEs.  Requires: EARTHMOON

eta = [0; 0; 3.944e8; 0;          % positions x1 y1 x2 y2
       0; 0;       0; 1.022e3];   % velocities v1 w1 v2 w2
t0 = 0;
secperday = 24 * 60 * 60;
tf = 40.0 * secperday;
N = [40 960];
names = {'FE','RK4'};
for k = 1:2
    for m = 1:2
        if m==1
            [tt,uu]  = forwardeuler(@earthmoon,eta,t0,tf,N(k));
        else
            [tt,uu] = rk4(@earthmoon,eta,t0,tf,N(k));
        end
        subplot(2,2,2*(k-1)+m)
        plot(uu(1,:)/1.0e6,uu(2,:)/1.0e6,'k-',uu(3,:)/1.0e6,uu(4,:)/1.0e6,'k-')
        xlabel('x  (Mm)'),  ylabel('y  (Mm)')
        axis([-500 500 -500 500]),  axis square,  grid on
        title(sprintf('N = %d %s',N(k),names{m}))
    end
end
