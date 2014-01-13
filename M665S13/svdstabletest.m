% SVDSTABLETEST  Following exercise 16.2 in Trefethen & Bau, evaluate
% forward and backward errors from SVD of random matrices.

m        = 50;     % set to small number if you want to see entries
fixsigns = true;   % set to 'false' to cause the 'difficulties' in (a)
sixpow   = false;  % set to 'true' to do (c)

[U,Xu] = qr(randn(m));
[V,Xv] = qr(randn(m));
S = diag(sort(rand(1,m),'descend'));
if sixpow,  S = S.^6;  end
A = U * S * V';

[U2, S2, V2] = svd(A);
if fixsigns
  swap = diag(sign(U(1,:)) ./ sign(U2(1,:)));
  U2 = U2 * swap;
  V2 = V2 * swap;
end

fprintf('|U - U2| = %.3e,  |S - S2| = %.3e, |V - V2| = %.3e\n',...
        norm(U-U2),norm(S-S2),norm(V-V2))
fprintf('    --> |A - U2 S2 V2*| = %.3e   (cond(A) = %.3e)\n',...
        norm(A-U2*S2*V2'),cond(A))
