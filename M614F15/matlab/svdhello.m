function svdhello;
% SVDHELLO shows "image compression" using SVD

% first build A=HELLO using hello.m
A = hello;
rank(A)

% use SVD for low rank approximations
[U,S,V] = svd(A);
c=15; showit(1,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('A itself has rank 10')
c=9; showit(2,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 9 approx')
c=7; showit(3,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 7 approx')
c=5; showit(4,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 5 approx')
c=3; showit(5,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 3 approx')
c=2; showit(6,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 2 approx')
c=1; showit(7,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 1 approx = \sigma_1 u_1 v_1*')
c=2; showit(8,U(:,c)*S(c,c)*V(:,c)'), title('\sigma_2 u_2 v_2*')
c=3; showit(9,U(:,c)*S(c,c)*V(:,c)'), title('\sigma_3 u_3 v_3*')

  % helper function
  function showit(pos,B);
  subplot(3,3,pos)
  imagesc(B),  colormap gray
  %surf(flipud(B)), view(2), shading interp     % <-- alternative look
  axis([1 40 1 15]),  set(gca,'XTick',[]),  set(gca,'YTick',[])
  end

end

