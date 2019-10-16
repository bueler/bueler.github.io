function showmat(A);
% SHOWMAT  Picture a 2 by 2 matrix A, including singular values and
% and corresponding vectors.  See also COND and SVD.
% Example: >> showmat(randn(2,2))
%          >> showmat([1 -1; -1 2])
%          >> showmat([1 0; -1 2])
%          >> showmat([1 0; -5 2])

if ~min((size(A)==[2 2])), error('matrix A is not 2 by 2'), end

[U,S,V] = svd(A);

% input space picture: unit circle
clf
subplot(1,2,1)
th=linspace(0,2*pi,100);
x=cos(th); y=sin(th);
plot(x,y,'--'), hold on
% add input singular vectors
for j=1:2
    plot([0 V(1,j)],[0 V(2,j)],'r')
    text(.5*V(1,j),.5*V(2,j),['v_' num2str(j)])
end
axis equal, axis([-1.2 1.2 -1.2 1.2]), hold off

% text description
  text(-0.7,2.3,[num2str(A(1,1),'%5.4f') '    ' num2str(A(1,2),'%5.4f')])  
text(-1.2,2.2,'A = ')
  text(-0.7,2.1,[num2str(A(2,1),'%5.4f') '    ' num2str(A(2,2),'%5.4f')])  
text(-1.2,1.75,['\sigma_1 = ' num2str(S(1,1),'%6.4f') ', \sigma_2 = ' num2str(S(2,2),'%6.4f')])
text(-1.2,1.5,['cond(A) = ' num2str(S(1,1)/S(2,2))])

text(-1.2,-2.0,'singular vectors and values:  A v_j = \sigma_j u_j','Color','r')

text(1.4,0.25,'A maps'), text(1.5,0,'--->')

% input space picture: ellipsoid
subplot(1,2,2)
hold off
out=A*[x; y];                  % apply A to every unit vector
plot(out(1,:),out(2,:),'--')
hold on
% add scaled output singular vectors
for j=1:2
    sig=S(j,j); ex=sig*U(1,j); ey=sig*U(2,j);
    plot([0 ex],[0 ey],'r')
    text(.5*ex,.5*ey,['\sigma_' num2str(j) ' u_' num2str(j)])
end
hold off
axis([-1.5*S(1,1) 1.5*S(1,1) -1.2*S(1,1) 1.2*S(1,1)])
axis equal

