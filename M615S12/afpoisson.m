function [xx,yy,U] = afpoisson(Jx,Jy,a_fcn,f_fcn)
% AFPOISSON  Finite difference approximation of a non-constant conductivity
% Poisson equation problem:
%   ( a u_x )_x + ( a u_y )_y + f = 0
% with a homogeneous Dirichlet boundary condition  u|_{bdry} = 0 on the square
% (-1,1) x (-1,1).  Uses centered-staggered finite differences.  Solves the
% linear system by using built-in sparse matrix solve.  Inputs include
% number of points Jx,Jy in x-,y- directions, and functions
%   diffusivity  a(x,y)  in a_fcn
%   source       f(x,y)  in f_fcn
% These functions mus be vectorized.
% Outputs are the grid xx,yy and the approximate solution U.
%
% Example:
%   >> a = @(x,y) 1.2 + sin(pi*y)
%   >> f = @(x,y) cos(pi*sqrt(x.^2+y.^2)) .* ((x.^2+y.^2)<0.25)
%   >> [xx,yy,U] = afpoisson(20,20,a,f);
%   >> mesh(xx,yy,U), xlabel x, ylabel y

dx = 2/Jx;    dy = 2/Jy;
xx = -1:dx:1;  yy = -1:dy:1;

% create A, b
N = (Jx-1)*(Jy-1);  % number of unknowns
printf("  number of rows in linear system:  N = %d\n", N)
tic
b = zeros(N,1);  % right-hand-side allocated
A = sparse(N,N);
for r = 1:Jx-1
   for s = 1:Jy-1
      k = kk(Jx,r,s);
      x = xx(r+1);  y = yy(s+1);

      % get staggered values of a(x,y)
      ae = feval(a_fcn,x+dx/2,y);
      aw = feval(a_fcn,x-dx/2,y);
      an = feval(a_fcn,x,y+dy/2);
      as = feval(a_fcn,x,y-dy/2);
      
      % entries of A are *not* scaled by clearing denominators
      % insert diagonal A entries
      A(k,k) = - ( ((ae + aw) / dx^2) + ((an + as) / dy^2) );
      % insert off-diagonal A entries
      if r ~= Jx-1, A(k,kk(Jx,r+1,s)) = ae / dx^2;  end
      if r ~= 1,    A(k,kk(Jx,r-1,s)) = aw / dx^2;  end
      if s ~= Jy-1, A(k,kk(Jx,r,s+1)) = an / dy^2;  end
      if s ~= 1,    A(k,kk(Jx,r,s-1)) = as / dy^2;  end
        
      % insert b entry
      b(k) = - feval(f_fcn,x,y);
   end
end
printf("  time to assemble linear system:   %.3f seconds\n", toc)
%see A:  spy(A),full(A),cond(A)

% solve linear system (and put soln in temporary column vector)
tic
w = A \ b;
printf("  time to solve linear system:      %.3f seconds\n", toc)

% put result into grid
U = zeros(Jx+1,Jy+1);  uex = U;
for r = 1:Jx-1
    for s = 1:Jy-1
        U(r+1,s+1) = w(kk(Jx,r,s));
    end
end
U = U';  % correct for mesh(), surf(), contour()
return

  function k = kk(Jx,r,s)  % local-to-global index function
  k = (s-1) * (Jx-1) + r;
  end
