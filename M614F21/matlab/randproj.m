function P = randproj(m,k)
% RANDPROJ Generate a random m x m orthogonal projector
% with rank k.  Example:
%   >> P = randproj(7,4)       % 7 x 7 matrix with rank 4

[Q,S,V] = svd(randn(m,m));     % using qr() is a bit faster
Qhat = Q(:,1:k);               % first k columns are ON set
P = Qhat * Qhat';
