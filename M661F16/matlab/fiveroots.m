% FIVEROOTS Use NEWTONSOLVE and illustrate with colors

r = @(x) [x(1) - x(2)^2 + 3;
          3*cos(x(1)) + x(2)];
J = @(x) [1,            -2*x(2);
          -3*sin(x(1)),       1];

%xex = [

N = 11;
A = zeros(N,N);
kk = 1:N;
x1 = linspace(-5,5,N)';
x2 = linspace(-5,5,N)';
for k = kk
    for l = kk
        x = newtonsolve([x1(k) x2(l)]',r,J,1.0e-6,30);
        A(k,l) = norm(x);
    end
end

imagesc(x1,x2,A)
set(gca,'ydir','normal')

hold on
plot(x2.^2-3,x2,'k')
plot(x1,-3*cos(x1),'k')
axis([-5 5 -5 5])
grid on
xlabel x,  ylabel y
hold off
