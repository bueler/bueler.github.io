% EXPLICITFIG  Script to make fig 2.2 in Morton & Mayer, 2nd ed.

J = 20;  dx = 1/J;  x = 0:dx:1;  % finite difference grid
dt = [0.0012 0.0013];            % cols of figure have different dt
tsteps = [0 1 25 50];            % rows of figure
NN = 406;                        % exact soln: use NN Fourier terms
xx = 0:.001:1;                   % plot exact soln on a fine grid

u0(1:J/2) = 2*x(1:J/2);          % initial condition defined piecewise
u0(J/2+1:J+1) = 2-2*x(J/2+1:J+1);

for k=1:2                        % k gives column in figure

   nu = dt(k)/(dx^2);            % nu value for column; eqn (2.20)
   for l=1:4                     % l gives row in figure

      % compute and plot approximate solution
      U = u0;                    % start over with initial condition
      for n=1:tsteps(l)          % does not execute if tsteps(l)<1
         % explicit scheme is eqn (2.19):
         U(2:J) = U(2:J) + nu*( U(3:J+1) - 2*U(2:J) + U(1:J-1) );
      end
      subplot(4,2,2*(l-1)+k)
      plot(x,U,'o-','markersize',4)  % better in Octave
      %plot(x,U,'.-')                % better in Matlab

      % compute and plot exact solution
      tt = tsteps(l)*dt(k);   uu = zeros(size(xx));
      sign = 1;
      for m=1:2:NN               % see (2.11) and exercise 2.1
         c = m*pi;   cc = c^2;
         uu = uu + sign * (8/cc) * exp(-cc*tt) * sin(c*xx);
         sign = -sign;
      end
      hold on,  plot(xx,uu),  hold off
      if ((l==1) & (k==1))       % labeled axes on upper-left subplot
         set(gca,'XTick',[]), set(gca,'YTick',[])  % remove ticks
         xlabel x, ylabel U
      else, axis off, end        % other plots get no axes
      if l==1, title(['\Delta t = ' num2str(dt(k))]), end

   end
end
