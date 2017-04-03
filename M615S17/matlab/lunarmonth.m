% LUNARMONTH  Solve Earth-Moon problem using N=960 RK4, and removing
% center-of-mass, to compute the length of a lunar month in days.

m1 = 5.972e24;  m2 = 7.348e22;
eta = [0; 0; 3.944e8; 0;          % positions x1 y1 x2 y2
       0; 0;       0; 1.022e3];   % velocities v1 w1 v2 w2
t0 = 0;  secperday = 24 * 60 * 60;  tf = 40.0 * secperday;
[tt,uu] = rk4(@earthmoon,eta,t0,tf,960);
ww = ( m1 * uu([1 2],:) + m2 * uu([3 4],:) ) / (m1 + m2);   % center-of-mass
uu = [(uu([1 2],:) - ww); (uu([3 4],:) - ww)];              % ... removed
%plot(uu(1,:)/1.0e6,uu(2,:)/1.0e6,'k-',uu(3,:)/1.0e6,uu(4,:)/1.0e6,'k-')

% distance of moon from its initial position
d = sqrt((uu(3,:)-uu(3,1)).^2 + (uu(4,:)-uu(4,1).^2));
%plot(tt/secperday,d)
[z,j] = min(d(2:end));   % don't look at t=0
j / 24
