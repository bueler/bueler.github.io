function fiveroots(N,maxiters)
% FIVEROOTS Use NEWTONSOLVE on an example, with a grid of starting points,
% and illustrate with colors

if nargin < 1,  N = 21;  end
if nargin < 2,  maxiters = 60;  end

r = @(x) [x(1) - x(2)^2 + 3;
          3*cos(x(1)) + x(2)];
J = @(x) [1,            -2*x(2);
          -3*sin(x(1)),       1];

function z = idroot(x)
	nrt = 6;
	xrt = [-1.92387   1.03736;
		   -1.09236  -1.38117;
		    0.85707  -1.96394;
		    2.46416   2.33755;
		    3.67478   2.58356;
		    6.22829  -3.03791];
    for j = 1:nrt
        if norm(x - xrt(j,:)') < 1.0e-2
            z = j;
            return
        end
    end
    z = 0;
end

Als = zeros(N,N);
Ano = zeros(N,N);
x1 = linspace(-5,8,N)';
x2 = linspace(-5,5,N)';
for l = N:-1:1
    for k = 1:N
        x0 = [x1(k) x2(l)]';
        xls = newtonsolve(x0,r,J,1.0e-6,maxiters);
        ji = idroot(xls);
        Als(l,k) = ji;
        if ji > 0
            fprintf('%d',ji)
        else
            fprintf(' ')
        end
        xno = newtonsolve(x0,r,J,1.0e-6,maxiters,false);
        Ano(l,k) = idroot(xno);
    end
    fprintf('\n')
end

for fn = 1:2
    figure(fn)
    if fn == 1
        imagesc(x1,x2,Als)
        title('with line search')
    else
        imagesc(x1,x2,Ano)
        title('NO line search')
    end
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
end

end
