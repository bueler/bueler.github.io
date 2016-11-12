% FIVEROOTS Use NEWTONSOLVE and illustrate with colors

r = @(x) [x(1) - x(2)^2 + 3;
          3*cos(x(1)) + x(2)];
J = @(x) [1,            -2*x(2);
          -3*sin(x(1)),       1];

nrt = 6;
xrt = [-1.92387   1.03736;
       -1.09236  -1.38117;
        0.85707  -1.96394;
        2.46416   2.33755;
        3.67478   2.58356;
        6.22829  -3.03791]

N = 101;
A = zeros(N,N);
kk = 1:N;
x1 = linspace(-5,8,N)';
x2 = linspace(-5,5,N)';
for k = kk
    for l = kk
        x = newtonsolve([x1(k) x2(l)]',r,J,1.0e-6,100);
        for j = 1:nrt
            if norm(x' - xrt(j,:)) < 1.0e-2
                A(l,k) = j;
                break
            end
        end
    end
end

imagesc(x1,x2,A)
set(gca,'ydir','normal')

% make unknowns into white
cm = colormap('jet');
cm(1,:) = [1 1 1];
colormap(cm)
colorbar

hold on
plot(x2.^2-3,x2,'k')
plot(x1,-3*cos(x1),'k')
axis([-5 8 -5 5])
grid on
xlabel x,  ylabel y

for j = 1:nrt
    plot(xrt(j,1),xrt(j,2),'ko')
    h = text(xrt(j,1)+0.3,xrt(j,2),num2str(j));
    set(h,'fontsize',20)
end
hold off

