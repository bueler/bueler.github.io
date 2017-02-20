% STABILITYP12  Look at the stability measure ||(A^h)^{-1}|| from P12.

j = [2,4,6,8,10,12];
m = 2.^j - 1;
h = pi ./ (m+1);
norms = zeros(size(h));
for k = 1:length(j)
    [x,U,A] = solveP12(m(k),0.0,pi,0.0,0.0);
    B = inv(full(A));
    norms(k) = norm(B,1);
end
loglog(h,norms,'ko')
axis([0.9*h(end), 1.1*h(1)]),  xlabel h
