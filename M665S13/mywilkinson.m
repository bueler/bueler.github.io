% MYWILKINSON  Reproduce Figure 12.1 in Trefethen & Bau.

C = poly(1:20)';    % coefficients of polynomial with roots 1,...,20
plot(1:20,zeros(1,20),'k.','markersize',20),  hold on
axis([-1 23 -9 9]),  axis off
plot([-1 23],[0 0],'k','linewidth',2.0)
plot([0 0],[-6 6],'k','linewidth',2.0)
for s = 1:100
  r = randn(21,1);
  z = roots( C .* (1 + 1.0e-10*r) );
  plot(z,'k.')
end
hold off
