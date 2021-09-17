% PCAEXAMPLE  Show an example of doing the basic principal component analysis
% (PCA) calculation on some synthesized data.  See
%    https://en.wikipedia.org/wiki/Principal_component_analysis

% synthesize (= make up) some crazy data I don't understand
%   n = 200  experiments
%   p = 3    features measured per experiment
n = 200;
M = randn(3,3);  [Q,R] = qr(M);   % generate a random rotation Q of 3-space
X = 5 * sqrt(abs([100 * randn(n,2), 20 * rand(n,1).^5 + pi])) * Q;

% plot the raw data, and mark the mean
figure(1)
scatter3(X(:,1), X(:,2), X(:,3))
hold on
mX = mean(X);
plot3(mX(1), mX(2), mX(3), 'ko', 'markersize', 10)
str = sprintf('mean (%.1f,%.1f,%.1f)',mX(1),mX(2),mX(3));
text(mX(1) + 3, mX(2) + 3, mX(3) + 3, str, 'fontsize', 12)
xlabel('feature 1'),  ylabel('feature 2'),  zlabel('feature 3')
hold off,  axis tight,  axis equal
title('raw data')

% remove the mean
X = X - mean(X);                   % note X is tall: 100 x 3

% the PCA is just the (reduced) SVD
[Uhat, Shat, W] = svd(X,0);        % X = Uhat * Shat * W^*
T = Uhat * Shat;                   % the score matrix; = X * W

% re-plot the data with the principal component directions shown
figure(2)
scatter3(X(:,1), X(:,2), X(:,3))
xlabel('feature 1'),  ylabel('feature 2'),  zlabel('feature 3')
colors = {'r','g','b'};
hold on
for k = 1:3
    spread = max(T(:,k)) - min(T(:,k));
    w = W(:,k) * spread / 2.0;
    plot3([-w(1) w(1)], [-w(2) w(2)], [-w(3) w(3)], colors{k})
end
legend('data with zero mean','pc1','pc2','pc3')
hold off,  axis tight,  axis equal

% show data projected along principal components
figure(3)
for k = 1:3
    subplot(3,1,k)
    hist(T(:,k),50,'facecolor',colors{k})   % show histogram along new axis
    fraction = Shat(k,k)^2 / sum(diag(Shat).^2);
    title(sprintf('principal component %d has %.4f of variance',k,fraction))
end
