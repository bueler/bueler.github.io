% PLOTBAREN  Plot shapes of the Barenblatt similarity solution.
set(0,'defaultlinelinewidth',2.0)
x = -10:.01:10;
tt = [0 5 20];
u = zeros(length(x),3);
for j=1:3
  psi = 1 - (x.^2) ./ (12 * sqrt(tt(j)+1));  psi = max(0,psi);
  u(:,j) = (tt(j)+1)^(-1/4) * sqrt(psi);
end
plot(x,u'), xlabel x, ylabel u
legend('t=0','t=5','t=20')

