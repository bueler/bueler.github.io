function [U, S, V] = showmatnaive(A)
% SHOWMATNAIVE Does exercise 4.3 in Trefethen and Bau the *wrong* way.
% Instead of using the built-in SVD we use naive means to maximize the norm
% ||Ax||_2 over all unit vectors.  As a result we *do* compute the SVD,
% so that is also returned.
% Example:
%   >> A = [1 1; 0 1];
%   >> [U S V] = showmatnaive(A);
%   >> norm(A - U*S*V')

if ~all([2 2] == size(A)), error('matrix A must be 2 x 2 and real'), end
if ~isreal(A), error('matrix A must be 2 x 2 and real'), end

%  A = [a b;
%       c d]
a = A(1,1);  b = A(1,2);  c = A(2,1);  d = A(2,2);

% f(theta) = ||A x||_2^2  where  x = [cos(theta); sin(theta)]
% this is condition f'(theta) = 0 which gives min and max
theta(1) = 0.5 * atan(2 * (a*b + c*d) / (a^2 + c^2 - b^2 - d^2));  % unsafe /0 ?
theta(2) = theta(1) + pi/2;
% the singular values are the max and min of sqrt(f)
sigma = zeros(2,1);
for k=1:2
  f = (a^2 + c^2) * cos(theta(k))^2 + (b^2 + d^2) * sin(theta(k))^2 + ...
        (a*b + c*d) * sin(2 * theta(k));
  sigma(k) = sqrt(f);
end

subplot(1,2,1)
% make circle with about 100 points
phi = 0:pi/50:2*pi;
plot(cos(phi),sin(phi),'k'),  hold on
% make axes
plot([-1.2 1.2],[0 0],'k')
plot([0 0],[-1.2 1.2],'k')
% plot v1, v2
for k = 1:2
  plot([0 cos(theta(k))], [0 sin(theta(k))], 'r')
  text(1.1*cos(theta(k)),1.1*sin(theta(k)),sprintf('v_%d',k))
end
hold off,  axis off,  axis equal

% compute vectors   sigma_i u_i = A v_i
S = diag(sigma);
V = [cos(theta(1)), cos(theta(2));
     sin(theta(1)), sin(theta(2))];
U = zeros(2,2);
for k=1:2
  U(:,k) = A * V(:,k);
  U(:,k) = U(:,k) / sigma(k);  % unsafe /0 ?
end

subplot(1,2,2)
plot(cos(phi),sin(phi),'.k'),  hold on   % unit circle for reference
plot(sigma(1)*U(1,1)*cos(phi) + sigma(2)*U(1,2)*sin(phi),...
     sigma(1)*U(2,1)*cos(phi) + sigma(2)*U(2,2)*sin(phi), 'k') % the ellipse
% plot vectors
for k=1:2
  plot([0 sigma(k)*U(1,k)],[0 sigma(k)*U(2,k)],'r')
  text(1.1*sigma(k)*U(1,k),1.1*sigma(k)*U(2,k),...
       sprintf('\\sigma_%d u_%d',k,k))
end
hold off,  axis off,  axis equal

