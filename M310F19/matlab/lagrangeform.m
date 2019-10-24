% LAGRANGEFORM  Show basis polynomials phi_i(x) and interpolating
% polynomial p(x) for some example data.
% See section 8.2 of Greenbaum & Chartier (2012).

x = [1 2 3 5 7];
y = [2 3 0 -1 1];
n = length(x)-1;

figure(1)
xfine = 0:.01:8;                % for plotting
p = zeros(size(xfine));
for i=1:n+1
    phi = ones(size(xfine));
    for j=1:n+1
        if j ~= i
           phi = phi .* ((xfine - x(j)) / (x(i) - x(j)));
        end
    end
    plot(xfine,phi),  hold on
    p = p + y(i) * phi;
end
legend('\phi_0','\phi_1','\phi_2','\phi_3','\phi_4')
plot(x,zeros(1,n+1),'ko')
plot(x,ones(1,n+1),'ko')
hold off
xlabel x
axis([0 8 -1 3])

figure(2)
plot(x,y,'ko',xfine,p)
legend('the data x,y','interpolating polynomial p(x)')
xlabel x
axis([0 8 -2 4])

