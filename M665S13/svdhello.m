function svdhello;
% SVDHELLO shows "image compression" using SVD

% first build A=HELLO
bl=ones(8,6);
H=bl; H(1:3,3:4)=zeros(3,2); H(6:8,3:4)=zeros(3,2);
E=bl; E(3,3:6)=zeros(1,4); E(6,3:6)=zeros(1,4); 
L=bl; L(1:6,3:6)=zeros(6,4);
O=bl; O(3:6,3:4)=zeros(4,2);
A=zeros(15,40); A(2:9,2:7)=H; A(3:10,10:15)=E; 
A(4:11,18:23)=L; A(5:12,26:31)=L; A(6:13,34:39)=O;
subplot(3,3,1), spy(A,'ko')
set(gca,'XTick',[]),  set(gca,'YTick',[])
title('spy(HELLO)')
showit(2,A),  title('HELLO as an image')

% use SVD for various "compressions"
[U,S,V] = svd(A);
c=7; showit(3,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 7 approx')
c=5; showit(4,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 5 approx')
c=3; showit(5,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 3 approx')
c=2; showit(6,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 2 approx')
c=1; showit(7,U(:,1:c)*S(1:c,1:c)*V(:,1:c)')
title('rank 1 approx')
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

