function colorsphere(A)
% COLORSPHERE  Color the unit sphere with the value of the Rayleigh quotient.
% Only works if A is 3x3 and real.  Also shows eigen spaces.
% Example:
%    >> A = randn(3,3);  A = diag(diag(A)) + triu(A,+1) + triu(A,+1)';
%    >> colorsphere(A)

% build sphere in polar coordinates
dd = pi/20;
[phi,theta] = meshgrid(0:dd:pi, 0:dd:2*pi);
z = cos(phi);
x = sin(phi) .* cos(theta);
y = sin(phi) .* sin(theta);

% build color matrix by evaluating Rayleigh quotient r(v) = v' (A v)
[m n] = size(phi);
C = zeros(m,n);
for j = 1:m
  for k = 1:n
    v = [x(j,k); y(j,k); z(j,k)];                  % unit vector
    C(j,k) = v' * (A * v);
  end
end

% plot it; imperfect
surf(x,y,z,C)
shading interp
[X, D] = eig(A);
hold on
for j = 1:3
  plot3([-X(1,j) X(1,j)],[-X(2,j) X(2,j)],[-X(3,j) X(3,j)],'ko-','markersize',12)
end
hold off
xlabel x, ylabel y, zlabel z
axis equal

