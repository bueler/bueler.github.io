% PLOTEVECTORS  Show complex-wave eigenvectors of circulant matrices.
m = 100;  j = 1:m;
for n = 1:2
  subplot(4,1,n),   hold on
  for k = [1 2 3]
    fk = exp(- i * (k - 1) * (2 * pi / m) * (j - 1));
    if n == 1,  plot(j,real(fk),'k'),
    else,       plot(j,imag(fk),'k'),  end
  end
  hold off,  axis([1 m -1.2 1.2])
end
f49 = exp(- i * (49 - 1) * (2 * pi / m) * (j - 1));
subplot(4,1,3),  plot(j,real(f49),'k'),  axis([1 m -1.2 1.2])
subplot(4,1,4),  plot(j,imag(f49),'k'),  axis([1 m -1.2 1.2])
xlabel('j')
