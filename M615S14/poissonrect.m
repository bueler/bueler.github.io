function maxerr = poissonrect(Jx,Jy)
% POISSONRECT  Solve Poisson equation
%   u_xx + u_yy + f = 0
% on a rectangle -1 < x < 1, 0 < y < 3.  Example:   >> poissonrect(60,50)

f = @(x,y) sin(y) - 2;

dx = 2/Jx;  dy = 3/Jy;  % grid spacing
nglobal = @(r,s,Jx,Jy) s * (Jx+1) + r + 1;   % global index from local coords

NN = (Jx+1)*(Jy+1);   % total number of grid points and unknowns; the boundary
                      % points are trivial rows (but unknowns in the system)
x = zeros(NN,1);  y = x;  U = x;  b = x;

A = sparse(NN,NN);    % assemble A, b
for s = 0:Jy
  for r = 0:Jx
    n = nglobal(r,s,Jx,Jy);
    x(n) = -1 + r * dx;  y(n) = 0 + s * dy;
    if (r > 0) & (r < Jx) & (s > 0) & (s < Jy)
      A(n,n) = (-2/dx^2) + (-2/dy^2);
      A(n,nglobal(r-1,s,Jx,Jy)) = 1/dx^2;
      A(n,nglobal(r+1,s,Jx,Jy)) = 1/dx^2;
      A(n,nglobal(r,s-1,Jx,Jy)) = 1/dy^2;
      A(n,nglobal(r,s+1,Jx,Jy)) = 1/dy^2;
      b(n,1) = - f(x(n),y(n));
    else
      A(n,n) = 1;       % trivial equation  U_{rs} = (known)
      if     r == 0,   b(n,1) = 1 + sin(y(n));
      elseif r == Jx,  b(n,1) = 1 + sin(y(n));
      elseif s == 0,   b(n,1) = x(n)^2;
      elseif s == Jy,  b(n,1) = x(n)^2 + sin(y(n));  end
    end
  end
end

if Jx+Jy < 30  % look at structure of A, and show global indices on grid
  figure(1),  clf,  spy(A)
  title(sprintf('A is a sparse %d x %d matrix with %d nonzeros',NN,NN,nnz(A)))
  figure(2),  clf,  plot(x(1:NN),y(1:NN),'o'),  hold on,  axis off
  xlabel x,  ylabel y
  for n=1:NN,  text(x(n)-dx/8,y(n)-dy/8,sprintf('%d',n)),  end
  hold off,  title(sprintf('the grid has %d unknowns',NN))
end

U = A \ b;    % solve!

[xx,yy] = ndgrid(-1:dx:1,0:dy:3);
uu = reshape(U,Jx+1,Jy+1);
figure(3),  clf,  surf(xx,yy,uu),  shading interp
xlabel x,  ylabel y,  zlabel('numerical solution U')
uexact = xx.^2 + sin(yy);
figure(4),  clf,  surf(xx,yy,uu-uexact),  shading interp
xlabel x,  ylabel y,  zlabel('error U-uexact')
maxerr = max(max(abs(uu-uexact)));
