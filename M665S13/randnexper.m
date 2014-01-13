% RANDNEXPER  do the numerical experiments suggested in Trefethen
% & Bau exercise 12.3

NN = 100;  % NN repetitions for each m
JJ = 5;    % m = 2^3, 2^4, ..., 2^(2+JJ)

makepdf = true;

set(0,'defaultaxesfontsize',9)

% part (a):  show eigenvalues themselves and gather data
figure(1)
rhos   = zeros(NN,JJ);
norms  = zeros(NN,JJ);
sigmin = zeros(NN,JJ);
for j = 1:JJ
  m = 2^(j+2);
  subplot(1,JJ,j)
  for n = 1:NN
    A = randn(m,m) / sqrt(m);
    norms(n,j)  = norm(A);
    sigmin(n,j) = min(svd(A));
    D = eig(A);
    rhos(n,j)   = max(abs(D));
    plot(real(D),imag(D),'.')
    hold on
  end
  hold off, axis equal
end
if makepdf,  print -dpdf randnexperAeig.pdf,  end

% part (a) and (b):  show spectral radius and norm
figure(2)
for part = 1:2
  subplot(2,1,part)
  for j = 1:JJ
    m = 2^(j+2);
    if part == 1
      semilogx(m, rhos(:,j), 'ko')
    else
      semilogx(m, norms(:,j), 'ko')
    end
    hold on
  end
  hold off, grid on
  xlabel('m')
  set(gca,'XTick',2.^(3:2+JJ))
  set(gca,'XTickLabel',{'8','16','32','64','128'})
  if part == 1
    axis([4 256 0.6 1.6]),  ylabel('spectral radius')
  else
    axis([4 256 1.2 2.6]),  ylabel('2-norm')
  end
end
if makepdf,  print -dpdf randnexperBrhonorm.pdf,  end


% part (c):  show fraction with small sigma_min
figure(3)
subplot(2,1,1)
for j = 1:JJ
  m = 2^(j+2);
  loglog(m, sigmin(:,j), 'ko')
  hold on
end
hold off, grid on
xlabel('m')
set(gca,'XTick',2.^(3:2+JJ))
set(gca,'XTickLabel',{'8','16','32','64','128'})
axis([4 256 1e-4 1e0])
ylabel('smallest singular value')
subplot(2,1,2)
prop = zeros(JJ,4);
for k = 1:4  % proportions  sigma_min < 1/2, 1/4, 1/8, 1/16
  for j = 1:JJ
    prop(j,k) = sum( sigmin(:,j) < (1/2)^k ) / NN;
  end
end
semilogx(2.^(3:2+JJ),prop,'o-'), grid on
legend('< 1/2', '< 1/4', '< 1/8', '< 1/16', 'location', 'southeast')
xlabel('m')
set(gca,'XTick',2.^(3:2+JJ))
set(gca,'XTickLabel',{'8','16','32','64','128'})
axis([4 256 -0.2 1.2])
ylabel('proportion')
if makepdf,  print -dpdf randnexperCsigmin.pdf,  end

