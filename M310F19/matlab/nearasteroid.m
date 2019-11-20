function nearasteroid(framepause,rtol)
% NEARASTEROID  Use ODE45 to solve a three-body problem in the plane,
% with fixed Sun at at origin, Earth, and a near-Earth asteroid of mass
% like the one that wiped-out the dinosaurs.  The differential equation
% is defined in function NARHS.
% Example:
%    >> nearasteroid

if nargin < 1,  framepause = 0.0;  end
if nargin < 2,  rtol = 1.0e-8;  end

au = 149597870700.0;  % m; 1 au is mean distance from Earth to Sun
espeed = 29.78e3;     % m/s; Earth orbital speed about 30 km/s
year = 31557600.0;    % s; Julian year in seconds

% asteroid initial speed adjusted to cause near-collision after about one year
u0 = [au,0.0, 1.1*au,0.0, 0.0,espeed, 0.0,0.4166*espeed];

% set tolerances and solve forward in time for 2 years
p = odeset('RelTol',rtol,'AbsTol',1.0e-14);
[tt,uu] = ode45(@narhs,[0.0,2.0*year],u0,p);

% report on solve
mindist = sqrt(min(sum((uu(:,1:2)-uu(:,3:4)).^2,2)));
fprintf('  ODE45 used %d t-values\n',length(tt))
fprintf('  minimum distance of asteroid pass was %.3e au = %.3e km\n',...
        mindist/au, mindist/1.0e3)

% plot in 2D x,y  (with animation if framepause>0)
figure(1)
axis([-1.6*au,1.6*au,-1.6*au,1.6*au]),  axis('square'),  grid on
xlabel('x  (m)'), ylabel('y  (m)')
if framepause > 0
    % animate plot (can be slow)
    hold on
    for k = 1:length(tt)
        plot(uu(k,1),uu(k,2),'b.')
        plot(uu(k,3),uu(k,4),'r.')
        if k == 1,  legend('Earth','asteroid'),  end
        pause(framepause)
    end
    hold off
else
    % static plot (no wait)
    plot(uu(:,1),uu(:,2),'b.')
    hold on,  plot(uu(:,3),uu(:,4),'r.'),  hold off
    legend('Earth','asteroid')
end

% add time axis to plot
figure(2)
tty = tt/year;  % convert time from seconds to years
plot3(uu(:,1),uu(:,2),tty,'b.')
hold on,  plot3(uu(:,3),uu(:,4),tty,'r.'),  hold off
axis([-1.6*au,1.6*au,-1.6*au,1.6*au,0,tty(end)]),  axis('square'),  grid on
xlabel('x  (m)'), ylabel('y  (m)'),  zlabel('t  (years)')
legend('Earth','asteroid')

