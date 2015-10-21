% SVDHI Show low rank approximations to the HI! matrix from HI.

A = hi;
[U,S,V] = svd(A,0);

B = zeros(size(A));
for i = 1:2
  for j = 1:2
    k = 2*(i-1) + j;
    B = B + S(k,k) * U(:,k) * V(:,k)';
    subplot(2,2,k),  imagesc(B),  colormap gray
    title(['rank ' num2str(k) ' approximation'])
  end
end
