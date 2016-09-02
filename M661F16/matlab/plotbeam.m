function plotbeam(h)
% PLOTBEAM Show tent pole (beam) represented by sine coefficients with "gates"
% (inequality constraints) shown.

N = length(h);
bounds = [0.9 1.1;
          1.2 1.4;
          0.4 0.6];

% pole
x = linspace(0.0,pi,201);
y = zeros(size(x));
for k = 1:length(x)
    y(k) = evalh(h,x(k));
end
plot(x,y), hold on
xlabel x
ylabel h

% gates
gate = @(x,y,dy) plot([x-0.06,x+0.06],[y,y],'k',[x,x],[y+dy,y],'k');
xj   = [1.0 2.0 3.0];
for j = [1 2 3]
    gate(xj(j),bounds(j,1),-0.05)
    gate(xj(j),bounds(j,2),+0.05)
end
hold off

    function z = evalh(hin,xin)
        kk = 1:N;
        z = hin * sin(kk * xin)';
    end

end

