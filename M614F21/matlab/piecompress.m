% PIECOMPRESS  Compress a monochrome image using the SVD.

% read the image
Acolor = imread('pie.png');
A = double(Acolor(:,:,2));  % grab green channel and make into double
% whos                      % observe that A is 150 x 200 array

% my Octave imread() has a bug; here is an alternate way to load:
%load pie.mat

% original image
figure(1)
colormap('gray'),  imagesc(A),  axis off
title(sprintf('rank %d: uncompressed',rank(A)))
[m, n] = size(A);
sizeA = m * n;    % number of entries in A

% compute SVD
[U, S, V] = svd(A);

% show rank k approximations
for k = [1 3 10 20]
    figure
    Ak = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
    colormap('gray'),  imagesc(Ak),  axis off
    ratio = (m*k + n*k + k) / sizeA;
    title(sprintf('rank %d: compression ratio %.3f', k, ratio))
end
