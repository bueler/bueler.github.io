function vismat(A);
% VISMAT  Picture action of a real 2x2 matrix A using singular values
% and left/right singular vectors.
% Examples:  >> vismat(randn(2,2))
%            >> vismat([1 1; 2 1])
%            >> vismat([1 1; 1 1])

% input checking
if ~all(size(A) == [2 2])
    error('matrix A is not 2 by 2')
elseif ~all(isreal(A))
    error('matrix has complex entries ... not visualizable')
end

% get the SVD factors
[U,S,V] = svd(A);

% input space picture
clf, subplot(1,2,1)
clrs = {'r', 'g'};
th = linspace(0,2*pi,100);
x = cos(th);  y = sin(th);       % the unit circle
plot(x,y,'--'), hold on
for j=1:2
    plot([0 V(1,j)], [0 V(2,j)], clrs{j})
    text(.5*V(1,j), .5*V(2,j), sprintf('v_{%d}',j))
end
axis equal,  axis([-1.2 1.2 -1.2 1.2]),  hold off

% text arrow
text(1.6, .25, 'A')
text(1.5, 0, '--->')

% output space picture
out = A * [x; y];                % apply A to the unit circle
subplot(1,2,2)
plot(out(1,:), out(2,:), '--'), hold on
for j=1:2
    sig = S(j,j);
    ex = sig * U(1,j);
    ey = sig * U(2,j);
    plot([0 ex], [0 ey], clrs{j})
    text(.5*ex, .5*ey, sprintf('\\sigma_{%d} u_{%d}',j,j))
end

% add values of singular values at top
sigstr = sprintf('\\sigma_1 = %6.4f, \\sigma_2 = %6.4f', S(1,1), S(2,2));
text(-0.6 * S(1,1), 1.2 * S(1,1), sigstr)

% scale axes appropriately
xbounds = [min(out(1,:)), max(out(1,:))];
ybounds = [min(out(2,:)), max(out(2,:))];
axis equal,  axis([1.2*xbounds, 1.2*ybounds]),  hold off
