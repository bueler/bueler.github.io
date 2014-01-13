function showrw(n);
% try "showrw(8)" then "showrw(12)"
% computes with an  n by 2^n  matrix, so be careful

% columns of A are binary expansions of numbers in [0,1]
for j=1:n
   for i=1:2^n
      A(j,i)=(mod((i-1)/2^(n-j),2)>=1);
   end;
end;

B=2*A-1; % binary -> Rademacher

% columns of R are number of returns to 0
R=zeros(n,2^n);
for j=2:n
   R(j,:)=R(j-1,:)+not(sum(B(1:j,:),1));
end;

figure(1);
spy(R); % draws a dot for nonzero matrix element of R
axis square;
set(gca,'xtick',[]); xlabel(''); ylabel('step n');
title('Subset of [0,1] corresponding to: returned after n steps?')

figure(2);
spy(R,6);
axis([0 2^(n-3) n/2 n+1]);
axis square;
set(gca,'xtick',[]); xlabel(''); ylabel('step n');
title('detail');