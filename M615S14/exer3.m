% EXER3  Solve this ODE BVP by finite differences:
%   y'' + sin(5 x) y = x^3 - x,  y(0)=0, y(1) = 0.

J = 10;  dx = 1/J;  x = (0:dx:1)';
b = zeros(J+1,1);
b(2:J) = dx^2 * ( x(2:J).^3 - x(2:J) );
A = sparse(J+1,J+1);
A(1,1) = 1.0;
for j=2:J
  A(j,[j-1, j, j+1]) = [1, - 2 + dx^2 * sin(5 * x(j)), 1];
end
A(J+1,J+1) = 1.0;

Y = A \ b;   % solve A Y = b

plot(x,Y,'-o','markersize',12), grid on, xlabel x
