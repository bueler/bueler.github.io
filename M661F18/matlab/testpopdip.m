function testpopdip(x0,tol)
% TESTPOPDIP  Solves
%     min   f(x) = (1/2) (x_1-1)^2 + (1/2) (x_2+1)^2
%     s.t.  x >= 0
% using POPDIP.  Prints digits which suggest that the convergence is
% quadratic as claimed in section 16.7.2 of Griva, Nash, Sofer (2009),
% namely in Theorem 16.17.

if nargin < 1,  x0 = [2;2];  end
if nargin < 2,  tol = 1.0e-10;  end

[xk,lamk,xklist] = popdip(x0,@quickquad,tol);

N = size(xklist,2);
for k = 1:N
    fprintf('%3d: %20.15f %20.15f\n',k,xklist(1,k),xklist(2,k));
end

plot(xklist(1,:),xklist(2,:),'-ko')
maxx = max(xklist(1,:));
maxy = max(xklist(2,:));
axis([0 1.1*maxx 0 1.1*maxy])
grid on
xlabel('x','fontsize',20)
ylabel('y','fontsize',20)
end % function testpopdip

    function [f,df,Hf] = quickquad(x)
    % QUICKQUAD  Quadratic function used in testing POPDIP.  Unconstrained
    % minimum is at (1,-1).
    f = 0.5 * (x(1)-1)^2 + 0.5 * (x(2)+1)^2;
    df = [x(1)-1;
          x(2)+1];
    Hf = [1, 0;
          0, 1];
    end % function quickquad

