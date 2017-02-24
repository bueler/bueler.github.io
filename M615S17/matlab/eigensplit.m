% EIGENSPLIT  Show eigenvalues of family of matrices B(x).

B = @(x) [ 2.0, -1.0, 1.0;
          -1.0,  0.0, 1.0;
             x,    x, 0.0];
figure(1),  hold on
for x = -5.0:0.01:1.0
    lam = eig(B(x));
    for k = 1:3
        plot(real(lam(k)),imag(lam(k)),'k.')
        if x == round(x)
            if (imag(lam(k)) == 0)
                text(real(lam(k)),imag(lam(k))+0.1,sprintf('%d',x))
            else
                text(real(lam(k))+0.1,imag(lam(k)),sprintf('%d',x))
            end
        end
    end
end
hold off,  xlabel('real part'),  ylabel('imaginary part')
