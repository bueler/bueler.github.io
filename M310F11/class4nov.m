% CLASS4NOV  Follows in-class session 4 Nov. on equally-spaced polynomial
% interpolation of the function  f(x) = sin(x)  on the interval  [0,pi].
% During class I sought  p_n(x)  so that  |f(x) - p_n(x)| <= 10^{-12},
% which is too optimistic.  Here I use a tolerance of 10^{-4} instead.

% Recall our by-hand analysis gives   |f(x) - p_n(x)| <= pi^{n+1} / (n+1)!,
% so we want to find  n  so that this ratio is less than 10^{-4}.
tol = 1e-4;
for n=1:50
  ratio = pi^(n+1) / factorial(n+1);
  if ratio < tol
    break
  end
end
n
% now we know that  n = 14  will work

% generate plot of  f(x)  and its polynomial interpolant  p(x) = p_n(x)
figure(1)
x = linspace(0,pi,1000);
f = sin(x);                       % y-values of the function
plot(x,f)                         % plot the function
hold on
xp = linspace(0,pi,n+1);          % the interpolation points
yp = sin(xp);
plot(xp,yp,'ro','markersize',14)  % plot the interpolation points as red circles
coeff = polyfit(xp,yp,n);         % the coefficients of the poly interpolant
p = polyval(coeff,x);             % y-values of the polynomial
plot(x,p,'g')                     % this plots p_n(x) in green, but it is
                                  %   identical to screen accuracy
hold off, axis tight
title('f(x) and interpolating poly p_{14}(x) are nearly identical')

% but the actual error is a lot smaller than 10^{-4}:
err = max(abs(f - p))

% figure that shows error in interpolating polynomials of different degrees
figure(2)
errn = zeros(5,1000);
nn = [3 6 8 10 14];               % list of degrees of polys
for j = 1:5
  xp = linspace(0,pi,nn(j)+1);
  coeff = polyfit(xp,sin(xp),nn(j));
  pnn = polyval(coeff,x);
  errn(j,:) = abs(f - pnn);
end
errn = max(1e-20,errn);           % protect against log(0)
semilogy(x,errn(1,:),x,errn(2,:),x,errn(3,:),x,errn(4,:),x,errn(5,:))
legend('p_3(x)','p_6(x)','p_8(x)','p_{10}(x)','p_{14}(x)')
grid on, xlabel x, title('error in p_n(x)')

