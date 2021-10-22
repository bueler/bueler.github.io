% NEWTONSECANTCOMPARE  Two examples which compare convergence of
% Newton and secant methods.

figure(1)
clf
N = 8;
for z = 1:2
      xn = zeros(1,N);
      xs = xn;
      if z == 1
          f = @(x) x - cos(x);
          dfdx = @(x) 1 + sin(x);
          tstr = 'x = cos(x)';
          xn(1) = 1.0;
          xs(1) = 1.0;
          xs(2) = 0.9;
      else
          f = @(x) x.^5 - x - 1;
          dfdx = @(x) 5 * x.^4 - 1;
          tstr = 'x^5 - x - 1 = 0';
          xn(1) = 1.0;
          xs(1) = 1.0;
          xs(2) = 1.1;
      end
      subplot(1,2,z)
      for k = 1:N-1
          xn(k+1) = xn(k) - f(xn(k)) / dfdx(xn(k));
          if k > 1
              if xs(k) == xs(k-1)
                  xs(k+1) = xs(k);
              else
                  ms = ( f(xs(k)) - f(xs(k-1)) ) / (xs(k) - xs(k-1));
                  xs(k+1) = xs(k) - f(xs(k)) / ms;
              end
          end
      end
      r = xn(N);
      en = abs(r - xn);
      es = abs(r - xs);
      k = 1:N;
      semilogy(k(en>0), en(en>0), 'o', k(es>0), es(es>0), '*')
      legend('Newton', 'secant')
      xlabel k
      ylabel('error  e_k = |r - x_k|')
      axis([1 N 1.0e-16 1.0])
      title(tstr)
end
