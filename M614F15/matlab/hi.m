function A = hi;
% HI  Generate 4 x 9 matrix with "HI!"

A = ones(4,9);
A(1:3,1:3) = [0 1 0;
              0 0 0;
              0 1 0];
A(2:4,5:7) = [0 0 0;
              1 0 1;
              0 0 0];
A([1 2 4],9) = 0;

% also look at result of:  rank(A),  spy(A)
imagesc(A), colormap gray
