function lam = resolveshow(A)
% RESOLVESHOW  Given a square matrix A, make a surface plot and a contour plot
% of the 2-norm of the resolvent norm, i.e.  g(z) = |(A-z I)^-1|_2.
% Returns the eigenvalues of A.
% Examples:
%   >> [A,B] = gennormal(5);  % A,B have same eigs; A normal but B not
%   >> resolveshow(A)         % normal case: contours round
%   >> resolveshow(B)         % nonnormal case
% See also: GENNORMAL

m = size(A,1);
if size(A,2) ~= m,  error('only works for square matrices'),  end
lam = eig(A);

R = max(abs(lam));
sc = 1.5;
x = linspace(-sc*R,sc*R,151);
zz = meshgrid(x,x);
gg = zeros(size(zz));
for k = 1:length(x)
    for l = 1:length(x)
        z = x(l) + i*x(k);
        t = min(svd(A - z*eye(m)));  % = |(A-z I)^-1|_2
        gg(k,l) = 1.0/(max(t,0.1));
    end
end

figure(1)
mesh(x,x,gg)
xlabel x,  ylabel y,  zlabel('|(A-z I)^-1|_2')

figure(2)
contour(x,x,gg,[0.5 1.0 2.0 3.0 5.0 10.0 15.0])
xlabel x,  ylabel y,  title('contours of |(A-z I)^-1|_2')
axis equal, axis tight

