% TANROOTS  Compute N eigenvalues and plot eigenfunctions of the 
% (Sturm-Liouville) problem
%     X''(x) + lambda^2 X(x) = 0
%     X(0) = 0
%     X'(1) + h X(1) = 0
% where h = 1.

N = 7;
lambda = zeros(1,N);
for k = 1:N
  % give a bracket on which there is a root
  a = (1.001)*(2*k-1)*(pi/2);
  b = k * pi;
  lambda(k) = fzero(@(x) tan(x)+x,[a b]);
end
lambda'
x = 0:.001:1;
XX = zeros(length(x),N);
for k = 1:N
  % compute eigenfunction
  XX(:,k) = sin(lambda(k) * x);
end
plot(x,XX)
xlabel x, ylabel('X_k(x)'), title('X_k(x) for k=1,2,...,7')

