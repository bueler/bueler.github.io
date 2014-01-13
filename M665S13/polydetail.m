% POLYDETAIL  Show that evaluating a polynomial from its coefficients
% can be poorly-behaved.
x = 1.930:0.001:2.070;
pa = polyval([1 -18 144 -672 2016 -4032 5376 -4608 2304 -512], x);
pb = (x - 2).^9;
plot(x,pa,'r',x,pb,'b-o'),  xlabel('x'),  axis tight
legend('from coefficients','from power (x-2)^9')
