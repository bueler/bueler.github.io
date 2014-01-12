% PLOTPOLYSQRT  Show how well Taylor polynomials p_n(x) approximate
%               the square root function on the interval [1,4].

x = linspace(1,4,1001)';               % points on [1,4], as a column
f = sqrt(x);
p1 = 2 + (1/4)*(x-4);                  % get started explicitly
p2 = p1 - (1/64)*(x-4).^2;

N = 70;                                % this many p_n(x)
pn = zeros(length(x),N);               % space for all p_n(x)
pn(:,1) = p1;
pn(:,2) = p2;
sign = -1;
for n = 3:N                            % count through the n-values
  sign = (-1) * sign;                  % generate alternating sign
  coeff = factorial(2*n-3) ...
            / ( 2^(4*n-3) * factorial(n-2) * factorial(n) );
  pn(:,n) = pn(:,n-1) + sign * coeff * (x-4).^n; % add next term
end

for n=1:N                              % replace each polynomial
  pn(:,n) = abs(f - pn(:,n));          %    with its error
end

semilogy(x,pn(:,[2 5 10 20 40 70])), grid on  % log scale on y
legend('n=2','n=5','n=10','n=20','n=40','n=70')
xlabel n, ylabel('|R_n(x)| = |f(x)-p_n(x)|')
