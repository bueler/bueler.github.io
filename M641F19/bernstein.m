function bernstein(n,x,delta)
% BERNSTEIN  Plots all of the Bernstein basis polynomials of a given degree n:
%            / n \
%   p_k(x) = |   |  x^k (1-x)^(n-k)
%            \ k /
% for k = 0,1,2,...,n.  If x,delta are given then also plots in figure 2 the
% sum over those basis polynomials where |(k/n)-x|>delta.  (Compare Carothers
% Lemma 11.5(iv).)
% Examples:  >> bernstein(5)
%            >> bernstein(20,0.4,0.2)
%            >> bernstein(80,0.4,0.2)

p = @(n,k,x) nchoosek(n,k) * x.^k .* (1-x).^(n-k);

figure(1),  clf,  hold on
xx = 0:.002:1;
labels = {};
for k = 0:n
    plot(xx,p(n,k,xx))
    labels{k+1} = sprintf('p_%d',k);
end
if n < 10
    legend(labels)
end
xlabel x
title(sprintf('n=%d Bernstein basis polynomials',n))
hold off,  grid on

if nargin == 3
    figure(2),  clf
    yy = zeros(size(xx));
    for k = 0:n
        if abs((k/n)-x) >= delta
            yy = yy + p(n,k,xx);
        end
    end
    plot(xx,yy,'b'),  hold on
    plot([x,x],[-0.02,0.02],'k')
    text(x,-0.05,'x')
    plot(x,1/(4*n*delta^2),'ro')
    axis([0,1,-0.1,1])
    hold off,  grid on
end

