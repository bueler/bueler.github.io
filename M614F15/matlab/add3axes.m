function add3axes(scale)
% ADD3AXES  Add axes for 3D figures.  Use "hold on" before
% this to make sense.

plot3([-scale 0],[0 0],[0 0],'k--','linewidth',2.0)
plot3([0 scale],[0 0],[0 0],'k')
text(1.2*scale,0,0,'x')
plot3([0 0],[-scale 0],[0 0],'k--','linewidth',2.0)
plot3([0 0],[0 scale],[0 0],'k')
text(0,1.2*scale,0,'y')
plot3([0 0],[0 0],[-scale 0],'k--','linewidth',2.0)
plot3([0 0],[0 0],[0 scale],'k')
text(0,0,1.2*scale,'z')

