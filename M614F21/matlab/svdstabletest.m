function svdstabletest(fixsigns,pow,m,tests)
% SVDSTABLETEST  Do Exercise 16.2 in Trefethen & Bau.  Evaluate
% forward and backward errors from SVD of random matrices.
% Usage:
%   >> svdstabletest           % part (a)
%   >> svdstabletest(true)     %      (b)
%   >> svdstabletest(true,6)   %      (c)

if nargin < 4,  tests = 5;  end          % number of tests
if nargin < 3,  m = 50;  end             % size of matrix A
if nargin < 2,  pow = 1.0;  end          % apply this power to sigmas
if nargin < 1,  fixsigns = false;  end   % apply sign fix

fprintf(' |U - U2|    |S - S2|    |V - V2|    |A - A2|     cond(A)\n')
for k = 1:tests
    [U,Xu] = qr(randn(m));
    [V,Xv] = qr(randn(m));
    S = diag(sort(rand(1,m),'descend'));
    if pow ~= 1.0
        S = S.^pow;
    end
    A = U * S * V';
    [U2, S2, V2] = svd(A);
    if fixsigns
        swap = diag(sign(diag(U)) .* sign(diag(U2)));
        U2 = U2 * swap;
        V2 = V2 * swap;
    end
    %plot(diag(U2'*U),'o')               % to motivate fixsigns mechanism
    fprintf('%.3e   %.3e   %.3e   %.3e   %.3e\n',...
          norm(U-U2),norm(S-S2),norm(V-V2),norm(A-U2*S2*V2'),cond(A))
end