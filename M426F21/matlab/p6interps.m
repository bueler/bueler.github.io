% P6INTERPS  Generate interpolation figures: polynomial,
% piecewise-linear, and cubic spline.  Solves problem
% P6 on Assignment #8.

% data
t = [-4 -2 0 1 2 4 6];
y = tanh(t);
xx = -4:.01:6;  yy = tanh(xx);  % sample points and f(x)

% part (a)
c = polyfit(t,y,6);  pa = polyval(c,xx);
figure(1),  plot(xx,pa, xx,yy, t,y,'ko')
legend('p_a(x)','f(x)=tanh(x)','interpolation points',...
       'location','southeast')
xlabel x,  ylabel y,  title('part (a): polynomial')
print -dpdf parta.pdf
fprintf('(a):  |f-pa|_inf = %.3f\n', norm(yy - pa,'inf'))

% part (b)
pb = interp1(t,y,xx,'linear');
figure(2),  plot(xx,pb, xx,yy, t,y,'ko')
legend('p_b(x)','f(x)=tanh(x)','interpolation points',...
       'location','southeast')
xlabel x,  ylabel y,  title('part (b): piecewise-linear')
print -dpdf partb.pdf
fprintf('(b):  |f-pb|_inf = %.3f\n', norm(yy - pb,'inf'))

% part (c)
pc = interp1(t,y,xx,'spline');
figure(3),  plot(xx,pc, xx,yy, t,y,'ko')
legend('p_c(x)','f(x)=tanh(x)','interpolation points',...
       'location','southeast')
xlabel x,  ylabel y,  title('part (c): cubic spline')
print -dpdf partc.pdf
fprintf('(c):  |f-pc|_inf = %.3f\n', norm(yy - pc,'inf'))

% part (d)
t9 = [-4 -3 -2 -1 0 1 2 4 6];
y9 = tanh(t9);
pd = interp1(t9,y9,xx,'spline');
figure(4),  plot(xx,pd, xx,yy, t9,y9,'ko')
legend('p_d(x)','f(x)=tanh(x)','interpolation points',...
       'location','southeast')
xlabel x,  ylabel y,  title('part (d): cubic spline (9 pts)')
print -dpdf partd.pdf
fprintf('(d):  |f-pd|_inf = %.3f\n', norm(yy - pd,'inf'))

% part (e)
c9 = polyfit(t9,y9,8);  pe = polyval(c9,xx);
figure(5),  plot(xx,pe, xx,yy, t9,y9,'ko')
legend('p_e(x)','f(x)=tanh(x)','interpolation points',...
       'location','southeast')
xlabel x,  ylabel y,  title('part (e): polynomial (9 pts)')
print -dpdf parte.pdf
fprintf('(e):  |f-pe|_inf = %.3f\n', norm(yy - pe,'inf'))
