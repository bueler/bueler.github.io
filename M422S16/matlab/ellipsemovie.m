function ellipsemovie(saveext)
% ELLIPSEMOVIE Visualize function
%               1
%   f(z) = z + ---
%               z
% by a movie of how it transforms circles centered at the origin (z-plane)
% into ellipses with foci +-2 (w-plane).  Shows unit disc in z-plane (pink)
% and foci of ellipses in w-plane.  Compare Exercises 6 and 7 in section II.6
% of Gamelin.
%
% Example:
%   >> ellipsemovie
% Example with saved files, plus commands to generate gif:
%   >> ellipsemovie('.png')  % generates files 000xx.png
%   >> exit
%   $ convert -resample 20x20 -delay 10 -loop 0 *.png ellipsemovie.gif

L = 4.1;
if nargin < 1,  saveext = '';  end

% parameterize circle
theta = linspace(0,2*pi,201);

% set up z-plane
figure(1),  clf
subplot(1,2,1),  hold on
fill(cos(theta),sin(theta),[1 0.75 0.75],'linewidth',0)  % unit disc
text(-0.9*L,0.9*L,'z','fontsize',16)
drawaxes(L),  hold off

% set up w-plane
subplot(1,2,2),  hold on
text(0.1*L,0.9*L,'w = z + 1/z','fontsize',16)
drawaxes(L),  hold off

% initial draw circle in z-plane and its image in w-plane
r = 0.04;
x = r * cos(theta);
y = r * sin(theta);
subplot(1,2,1),  hold on
hz = plot(x,y,'k','linewidth',2.0);
A = 1.0 + 1.0/r^2;
B = 1.0 - 1.0/r^2;
subplot(1,2,2),  hold on
hw = plot(A*x,B*y,'k','linewidth',2.0);
plot([-2 2],[0 0],'k.','markersize',10.0)  % foci of ellipses

% redraw at successive radii, for a movie
rlist = [0.24:0.02:1 1.05:.05:2 2.1:.1:4];
while true  % loop forever (if not saving)
    for j = 1:length(rlist)
        r = rlist(j);
        if length(saveext) > 0
            print(sprintf('%05d%s',j,saveext));
        end
        % circle in z-plane
        x = r * cos(theta);
        y = r * sin(theta);
        set(hz, 'XData', x)
        set(hz, 'YData', y)
        % image in w-plane
        A = 1.0 + 1.0/r^2;
        B = 1.0 - 1.0/r^2;
        set(hw, 'XData', A*x)
        set(hw, 'YData', B*y)
        sleep(0.1)
    end
    if length(saveext) > 0,  break,  end
end

end  % function ellipsemovie

    function drawaxes(L)
    plot([-L L],[0 0],'k','linewidth',1.0)
    plot([0 0],[-L L],'k','linewidth',1.0)
    axis equal, axis tight, axis off
    end

