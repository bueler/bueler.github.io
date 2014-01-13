function ddecchart(rho,er);
% DDECCHART  Produce the stability chart of a DDE given array of 
%    spectral radii.
%
%    ddecchart(rho,er);
%        rho = (d=1,2,3) dimensional array of spectral radii
%        er  = 1 by 2*d 
%
%    See DDECSPECT.

% (3/2/03 ELB)

if nargin~=2, error('needs 2 input arguments'), end
d=ndims(rho); 
en=size(rho);
if (d==2)&(sum(size(rho)==[1 1])), d=1; end  % if rho is a vector
if length(er)~=2*d, error('parameter range must be a length 2d row vect'), end

figure, clf % new figure

if d==1, % eps = [eps]
   epslist=linspace(er(1),er(2),en(1));
   plot(epslist,ones(size(epslist)),'--',epslist,rho,'.-','MarkerSize',16),
   xlabel([num2str(en(1)) ' values of parameter']),
   ylabel('spectral radius')
elseif d==2, % eps = [a b]
   alist=linspace(er(1),er(2),en(1)); blist=linspace(er(3),er(4),en(2));
   if (length(alist)>1)&(length(blist)>1),
%      [c,h] = contour(alist,blist,rho',[.9 1.0 1.1]);
      contourf(alist,blist,rho',[1.0 1.0]); colormap gray
%      if ~isempty(c), clabel(c,h), end,
      xlabel([num2str(en(1)) ' values of parameter 1']),
      ylabel([num2str(en(2)) ' values of parameter 2']),
   else, warning('no chart output: too few values of rho'), end
elseif d==3, % eps = [a b c]
   al=linspace(er(1),er(2),en(1));
   bl=linspace(er(3),er(4),en(2));
   cl=linspace(er(5),er(6),en(3));
   if (length(al)>1)&(length(bl)>1)&(length(cl)>1),
      [XX,YY,ZZ]=meshgrid(bl,al,cl);  % note strange order
      rhocut=min(rho,2*ones(size(rho)));
      cbarlevels=[0.0 0.15 0.35];
      slice(XX,YY,ZZ,rhocut,er(4),er(2),cl(1:length(cl)-1)), colorbar
      ylabel([num2str(en(1)) ' values of parameter 1']),
      xlabel([num2str(en(2)) ' values of parameter 2']),
      zlabel([num2str(en(3)) ' values of parameter 3']),
      title('from DDECHART: colors denote spectral radius cut off at 2.0')

%%% alternate plot type
%      [X,Y,Z]=ndgrid(al,bl,cl);
%      [N1 N2 N3]=size(rho); %=size(X)=size(Y)=size(Z)
%      NNN=N1*N2*N3; rho=reshape(rho,1,NNN);
%      X=reshape(X,1,NNN); Y=reshape(Y,1,NNN); Z=reshape(Z,1,NNN);
%      X=X(rho<=1); Y=Y(rho<=1); Z=Z(rho<=1);  % get only the stable points
%      plot3(X,Y,Z,'.','Markersize',16), axis(er),

   else, warning('no chart output: too few values of rho'), end
else, error('only produces charts in 1, 2, or 3 dimensions'), end

