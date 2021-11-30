function bezier(p0, p1, p2, p3)
% BEZIER  Plot a cubic Bezier curve for control points p0, p1, p2, p3.
% Example:
%   >> bezier([0,0], [0.2,1], [1.8,1], [2,0])   % minute 3:30 in video

t = linspace(0,1,401)';
p = zeros(401,2);
for k = 1:length(t)
    % compute by "lerps all the way down"
    f0 = (1 - t(k)) * p0 + t(k) * p1;
    f1 = (1 - t(k)) * p1 + t(k) * p2;
    f2 = (1 - t(k)) * p2 + t(k) * p3;
    q0 = (1 - t(k)) * f0 + t(k) * f1;
    q1 = (1 - t(k)) * f1 + t(k) * f2;
    p(k,:)  = (1 - t(k)) * q0 + t(k) * q1;
end
clf
plot((1-t)*p0(1)+t*p1(1),(1-t)*p0(2)+t*p1(2),'r','linewidth',0.5)
hold on
plot((1-t)*p1(1)+t*p2(1),(1-t)*p1(2)+t*p2(2),'r','linewidth',0.5)
plot((1-t)*p2(1)+t*p3(1),(1-t)*p2(2)+t*p3(2),'r','linewidth',0.5)
plot([p0(1) p1(1) p2(1) p3(1)], [p0(2) p1(2) p2(2) p3(2)], 'bo')
plot(p(:,1),p(:,2),'k','linewidth',5)
hold off
axis equal, axis off
