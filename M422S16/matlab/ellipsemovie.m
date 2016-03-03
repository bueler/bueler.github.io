function ellipsemovie
% ELLIPSEMOVIE fixme

L = 4.1;

% parameterize circle
theta = linspace(0,2*pi,201);

figure(1)
clf

% set up z-plane
subplot(1,2,1)
hold on
drawaxes(L)
fill(cos(theta),sin(theta),[1 0.4 0.4])
text(-0.9*L,0.9*L,'z','fontsize',16)
axis equal, axis tight, axis off
hold off
% set up w-plane
subplot(1,2,2)
hold on
drawaxes(L)
text(0.1*L,0.9*L,'w = z + 1/z','fontsize',16)
axis equal, axis tight, axis off
hold off

% initial draw
r = 0.04;
x = r * cos(theta);
y = r * sin(theta);
subplot(1,2,1), hold on
hz = plot(x,y,'k','linewidth',2.0);
A = 1.0 + 1.0/r^2;
B = 1.0 - 1.0/r^2;
subplot(1,2,2), hold on
hw = plot(A*x,B*y,'k','linewidth',2.0);

% redraws
while true
    for r = [0.24:0.02:1 1.05:.05:2 2.1:.1:4]
        % draw circle in z-plane
        x = r * cos(theta);
        y = r * sin(theta);
        set(hz, 'XData', x)
        set(hz, 'YData', y)
        % draw image in w-plane
        A = 1.0 + 1.0/r^2;
        B = 1.0 - 1.0/r^2;
        set(hw, 'XData', A*x)
        set(hw, 'YData', B*y)
        sleep(0.1)
    end
end

end

    function drawaxes(L)
    plot([-L L],[0 0],'k','linewidth',1.0)
    plot([0 0],[-L L],'k','linewidth',1.0)
    end

