% WILK  Show Wilkinson's example, that the problem of finding the roots
% of a polynomial from its coefficients has a large condition number.
% Consider this degree 20 polynomial:
%   p(x) = (x - 1) (x - 2) (x - 3) ... (x - 20)
% Note we know its exact roots.  If we change the coefficients in the
% 10th decimal place then the roots move a huge amount.

% the exact coefficients of p(x)
a = [1, -210,                  +20615,                 -1256850, ...
        +53327946,             -1672280820,            +40171771630, ...
        -756111184500,         +11310276995381,        -135585182899530, ...
        +1307535010540395,     -10142299865511450,     +63030812099294896, ...
        -311333643161390640,   +1206647803780373360,   -3599979517947607200, ...
        +8037811822645051776,  -12870931245150988800,  +13803759753640704000, ...
        -8752948036761600000,  +2432902008176640000];

% plot where the exact roots are
plot(1:20,zeros(1,20),'r.','markersize',20)
axis([0 21 -2 2]),  hold on

% change the polynomial coefficients by a small amount and re-compute
% the roots
for j = 1:100
    apert = a + 1.0e-10 * randn(1,21);
    r = roots(apert);
    plot(real(r),imag(r),'k.','markersize',12)
end

% finalize the figure
hold off
legend('original roots of p(x)', 'roots of perturbed polynomial')
