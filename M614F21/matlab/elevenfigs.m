% ELEVENFIGS  Generate Figures 11.1 and 11.2 in Lecture 11 of
% Trefethen & Bau.

x = -5:5;
y = [0 0 0 1 1 1 0 0 0 0 0];
xx = -5.5:.01:5.5;     % for plotting

degree = [10 7];
for j = 1:2
    figure(j)
    p = polyfit(x,y,degree(j));
    plot(xx,polyval(p,xx),'k'),  hold on
    axis([-5.5 5.5 -2 5])
    plot(x,y,'kx')
    plot([-5.5 5.5], [0 0], 'k')    % x-axis
    plot([0 0], [-2 5], 'k')        % y-axis
    axis off,  hold off
end
