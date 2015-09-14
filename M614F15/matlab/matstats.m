% MATSTATS  Compute and plot scalar fcns of random matrices.

N = 10;           % number of tries
S = 9;            % maximum size is m = 2^S
mmm = 2.^(1:S);   % yes, this really works!
Z=zeros(S,N);
ranks=Z;  norms=Z;  invnorms=Z;  absdets=Z;  % space to store results

for k = 1:S
  m = mmm(k);
  for n = 1:N
    A = randn(m,m);
    ranks(k,n) = rank(A);
    if ranks(k,n) ~= m
      fprintf('THIS IS SHOCKING:  rank(A) is *not* m')
    end
    norms(k,n) = norm(A);
    invnorms(k,n) = norm(inv(A));
    absdets(k,n) = abs(det(A));
  end
end

figure(1)
loglog(mmm,norms,'ko','markersize',18,mmm,invnorms,'r*','markersize',14)
xlabel('m = size of A'),  grid on,  set(gca,'XTick',mmm)

figure(2)
loglog(mmm,absdets,'ko','markersize',18)
xlabel('m = size of A'),  grid on,  set(gca,'XTick',mmm)
