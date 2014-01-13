% exercise 9.1 (c), Trefethen & Bau, page 64
nulist = 1:15;
dx = zeros(size(nulist));  err = dx;  % space for dx, errors

for j = 1:length(nulist);
  dx(j) = 2^(-nulist(j));
  x = (-1.0:dx(j):1.0)';
  A = [x.^0 x.^1 x.^2 x.^3];
  [Q,R] = qr(A,0);
  Papprox = Q(:,4) / Q(end,4);    Pexact = 2.5 * x.^3 - 1.5 * x;
  err(j) = max(abs(Papprox - Pexact));
  fprintf('dx = 2^{-%2d}:  err = %.4e\n',nulist(j),err(j))
end

loglog(dx,err,'o','markersize',12)
p = polyfit(log(dx(4:15)),log(err(4:15)),1);
fprintf('data suggests err(dx) = O(dx^{%.4f})\n',p(1))
hold on,  loglog(dx,exp(p(2))*dx.^p(1),'r--'), hold off
xlabel('\Delta x')
