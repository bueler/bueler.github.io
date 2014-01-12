% PLOTAIRY  Plots partial sums of the series for the Airy function
%      y(t) = sum_{k=0}^infty a_(3k) t^(3k)
% where a_0=1 and a_(3k) = - a_(3(k-1)) / ((3k)(3k-1)).  Also plots the
% same function computed using Matlab's built-in AIRY.
% See also:  AIRY, CUMSUM.

Nlist=[3 6 10 20 30 40 50];  % do these partial sums
t=-3:.01:17;  % plot on this interval

a=ones(max(Nlist)+1,1);  % create space
tpow=ones(max(Nlist)+1,length(t)); % create space
for k=1:max(Nlist)
    a(k+1) = -a(k)/((3*k)*(3*k-1));  %  a(k+1)=a_(3k)
    tpow(k+1,:) = t.^(3*k);
end
aa = repmat(a,1,length(t)); % make array of coeffs; same size as tpow
sums = cumsum(aa.*tpow); % compute partial sums

figure(1)
plot(t,sums(Nlist,:)')
title('partial sums')
xlabel t, ylabel y, axis([min(t) max(t) -3 3]), grid on
legend('N=3','N=6','N=10','N=20','N=30','N=40','N=50')

figure(2)
c=[airy(0,0) airy(2,0); airy(1,0) airy(3,0)]\[1; 0];
plot(t,real(c(1)*airy(0,-t)+c(2)*airy(2,-t)))
title('as computed by built-in AIRY')
xlabel t, ylabel y, axis([min(t) max(t) -3 3]), grid on
