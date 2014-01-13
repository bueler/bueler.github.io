function svdframes(A)
% SVDFRAMES  Four-frame picture showing action of A as sequence of actions
% of the SVD factors,  A = U S V'.  First picture shows an orthonormal basis of
% three vectors, namely the columns of unitary V.  Second picture shows result
% of application of V' = V^*, giving standard basis.  Third picture shows
% stretched standard basis, from application of S = \Sigma.  Fourth picture is
% rotation and/or reflection of third picture, namely after application of
% unitary U.
%
% Applies only to 3 x 3 real matrices.
%
% Example:  >> A = magic(3)/5
%           >> svdframes(A)
%
% Seems to only work well in Matlab, not Octave (graphics reasons).
%
% Anyone: write a pylab version?

if ~all(size(A)==[3 3]), error('applies only to 3x3 matrices'), end
if ~all(isreal(A)), error('applies only to real matrices'), end

[U, S, V] = svd(A);

L = 1.2*S(1,1);  % scale axes etc. according to largest singular value, = norm(A)

figure, clf
subplot(221), plotaxes(L)
plotthree(V,'r')
finalaxes(L,'x = \{cols of V\}')

subplot(222), plotaxes(L)
plotthree(eye(3),'g')
finalaxes(L,'V^* x')

subplot(223), plotaxes(L)
plotthree(S,'b')
finalaxes(L,'S V^* x')

subplot(224), plotaxes(L)
plotthree(U * S,'m')
finalaxes(L,'U S V^* x = A x')

function plotaxes(L)
  hold on
  plot3([-L L],[0 0],[0 0],'k'), text(1.1*L,0,0,'x')
  plot3([0 0],[-L L],[0 0],'k'), text(0,1.1*L,0,'y')
  plot3([0 0],[0 0],[-L L],'k'), text(-0.1*L,0,0.9*L,'z')
  hold off

function plotthree(T,color)
  hold on
  for j=1:3
    v = T(:,j);   style = color;
    if j==2,     style = [style '--'];
    elseif j==3, style = [style '-.']; end
    plot3([0 v(1)],[0 v(2)],[0 v(3)],style,'linewidth',3.0)
  end
  hold off

function finalaxes(L,mytitle)
  text(1.0*L,-0.5*L,1.0*L,mytitle)
  hold off
  axis equal
  axis tight
  axis off
  view(135.0,30.0)
  zoom(2.3)

