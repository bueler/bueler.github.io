function [x, y, U] = ell(JJ)
% ELL computes and shows the first eigenfunction u of the Laplacian
%   A u = u_xx + u_yy
% on an "L"-shaped region.  This region is the union of 3 unit squares:
%   R = [0,1]x[0,1] U [0,1]x[1,2] U [1,2]x[0,1]
% When assembling the matrix we think of R in two unequal parts:
%   xxx         top
%   xxx         block
%   xxx
%   xxxxxx
%   xxxxxx      bottom
%   xxxxxx      block
% See also DEL2.  In Matlab (not octave) see also LOGO and MEMBRANE.
% This example illustrates the use of a local-to-global indexing
% function; see 
% Example on a coarse grid shows 3 figures (grid, spy(A), surf(u)):
%   >> ell(4);
% Example on a finer grid just shows a surface plot of u:
%   >> ell(25);

dx = 1/JJ;  dy = dx;  % grid spacing
% include space for padding
x = zeros((2*JJ-1)^2,1);  y = x;

% number of grid points in the L is:
NN = 3 * (JJ-1)^2 + 2 * (JJ - 1);
A = sparse(NN,NN);

% assemble bottom block
for s = 1:JJ-1
  for r = 1:2*JJ-1
    n = nglobal(r,s,JJ);  x(n) = r * dx;  y(n) = s * dy;
    A(n,n) = (-2/dx^2) + (-2/dy^2);
    if r>1
      A(n,nglobal(r-1,s,JJ)) = 1/dx^2;
    end
    if r<2*JJ-1
      A(n,nglobal(r+1,s,JJ)) = 1/dx^2;
    end
    if s>1
      A(n,nglobal(r,s-1,JJ)) = 1/dy^2;
    end
    if (s<JJ-1) | (r<JJ)
      A(n,nglobal(r,s+1,JJ)) = 1/dy^2;
    end
  end
end
% assemble top block
for s = JJ:2*JJ-1
  for r = 1:JJ-1
    n = nglobal(r,s,JJ);  x(n) = r * dx;  y(n) = s * dy;
    A(n,n) = (-2/dx^2) + (-2/dy^2);
    if r>1
      A(n,nglobal(r-1,s,JJ)) = 1/dx^2;
    end
    if r<JJ-1
      A(n,nglobal(r+1,s,JJ)) = 1/dx^2;
    end
    A(n,nglobal(r,s-1,JJ)) = 1/dy^2;
    if s<2*JJ-1
      A(n,nglobal(r,s+1,JJ)) = 1/dy^2;
    end
  end
end

if JJ < 10
  % look at structure of A
  figure(1),  clf,  spy(A)
  title(sprintf('A is a sparse %d x %d matrix with %d nonzeros',NN,NN,nnz(A)))
  % show grid with global indexing
  figure(2),  clf,  plot(x(1:NN),y(1:NN),'o'),  hold on
  xlabel x,  ylabel y
  for n=1:NN
    text(x(n)-dx/3,y(n)-dy/3,sprintf('%d',n))
  end
  hold off
  title(sprintf('the grid has %d unknowns',NN))
end

% we are computing the first eigenmode
% which has the smallest-magnitude eigenvalue
[U,lambda] = eigs(A,1,'sm');
U = abs(U)/max(abs(U));   % normalize so it is > 0 and has max 1
abs(lambda)

% we will plot on (most of) the whole [0,2]x[0,2] square
[xx,yy] = meshgrid(dx:dx:2-dx,dx:dx:2-dx);

% pad x,y,U to get flat area in missing box, for logo-like surface
for s = JJ:2*JJ-1
  for r = JJ:2*JJ-1
    n = NN + (s - JJ) * JJ + (r - JJ) + 1;
    x(n) = r * dx;  y(n) = s * dy;
  end
end
Uplot = zeros(size(x));
Uplot(1:NN,1) = U;

uu = griddata(x,y,Uplot,xx,yy);
figure(3),  clf,  surf(xx,yy,uu)
shading interp
axis off
colormap('copper')
view([230.0,45.0])
end

function n = nglobal(r,s,JJ)
  if s < JJ
    n = (s - 1) * (2*JJ-1) + r;
  else
    n = (JJ-1) * (2*JJ-1) + (s - JJ) * (JJ-1) + r;
  end
end

