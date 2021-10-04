% NASADATA  Input and plot temperature anomaly data.  These are temperature
% differences in Celsius relative to the 1951-1980 mean.  See page 96 of
% Driscoll & Braun, Fundamentals of Numerical Computation, SIAM 2018.

% 10 data points
t = (1955:5:2000)';
y = [-0.0480 -0.0180 -0.0360 -0.0120 -0.0040 ...
      0.1180  0.2100  0.3320  0.3340  0.4560]';

% plot the data
plot(t,y,'bo')
set(gca,'xtick',t)
xlabel('year')
ylabel('anomaly (C)')

% use polyfit to exactly fit the data as on page 97
n = length(t);
t = (t - 1955) / 10;        % this shift and scale makes fitting
                            % better conditioned
p = polyfit(t,y,n-1);

% plotting technique is a little different ...
tfine = 1955:0.01:2000;    % fine grid for plotting
hold on
plot(tfine,polyval(p,(tfine - 1955)/10), 'r')

% build  10 x 2  matrix and "solve" overdetermined system
V = [t.^0 t];
c = V \ y;
fprintf('slope is %.2f C per decade\n',c(2))

% plot line as well
plot(tfine,c(1) + c(2) * (tfine - 1955)/10, 'g')
legend('data', 'exact fit', 'linear fit', ...
       'location', 'northwest')
hold off,  axis tight
