function zout = vismult(z1,z2,both)
% VISMULT  Visualize complex multiplication.  With third argument,
% also shows addition parallelogram.
% Examples:
%   >> vismult(1+i,2)
%   >> vismult(1+i,2,'both')
%   >> vismult(2+i,-3+2i,'both')

L = max([abs(z1) abs(z2) abs(z1+z2) abs(z1*z2) 1.3]);
plot([-L L],[0 0],'k')
hold on
plot([0 0],[-L L],'k')
plot(1,0,'k+','markersize',12)
plot(0,1,'k+','markersize',12)
plot(real(z1),imag(z1),'ko','markersize',6)
plot(real(z2),imag(z2),'ko','markersize',6)
shift = 0.05*L;
text(shift+real(z1),imag(z1),'z_1','fontsize',14)
text(shift+real(z2),imag(z2),'z_2','fontsize',14)
w = z1 * z2;
plot(real(w),imag(w),'ko','markersize',6)
text(shift+real(w),imag(w),'z_1z_2','fontsize',14)
if nargin > 2
    % add plot of sum, and resulting parallelogram
    w = z1 + z2;
    plot(real(w),imag(w),'ko','markersize',6)
    text(shift+real(w),imag(w),'z_1+z_2','fontsize',14)
    plot([0 real(z1) real(w)],[0 imag(z1) imag(w)],'k','linewidth',0.5)
    plot([0 real(z2) real(w)],[0 imag(z2) imag(w)],'k--','linewidth',0.5)
end
axis off
hold off
