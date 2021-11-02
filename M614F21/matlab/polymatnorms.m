% POLYMATNORMS  Do Exercise 12.2 (b) from Trefethen & Bau.

nn = 1:30;
Anorms = zeros(size(nn));
for n = nn
    m = 2*n-1;
    x = linspace(-1,1,n);
    y = linspace(-1,1,m);
    Anorms(n) = norm(polymat(x,y),'inf');
end
semilogy(nn,Anorms,'ko'),  hold on
NN = nn(5:end);
semilogy(NN,2.^NN ./ (exp(1)*(NN-1).*log(NN)),'k--'),  hold off
grid on, xlabel n, ylabel('||A||_{\infty}')
