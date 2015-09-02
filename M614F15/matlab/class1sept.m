% draft of what I do in class

figure(1)

v = [1 5 2]'

plot3([0 v(1)],[0 v(2)],[0 v(3)])

hold on
add3axes(5)
hold off
axis off

figure(2)

A = [-1 1; 0 5; 1 2]

for j = 1:100
    x = randn(2,1);
    x = x / norm(x);  % late addition
    subplot(1,2,1)
    hold on
    plot(x(1),x(2),'o')
    subplot(1,2,2)
    hold on
    y = A * x;
    plot3(y(1),y(2),y(3),'o')
end
subplot(1,2,1)
add3axes(2)
view(2)
axis equal
axis off
hold off
subplot(1,2,2)
add3axes(5)
view(3)
axis equal
axis off
hold off

