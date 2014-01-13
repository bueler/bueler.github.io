% AKDIST  Build a matrix of distances.  Use "classical metric multiscaling
% analysis" to embed in the plane (i.e. build the map from the distances).
% See
%   www.math.pku.edu.cn/teachers/yaoy/Fall2011/lecture11.pdf
% for one version of the calculation.  See also Matlab command CMDSCALE
% for black box version of it.   This site was source of distances
%   http://www.findlocalweather.com/how_far_is_it/ak/fairbanks

% input distance information
names = ["Anchorage";  % 1
         "Fairbanks";  % 2
         "Juneau   ";  % 3
         "Barrow   ";  % 4
         "Nome     ";  % 5
         "Unalaska ";  % 6
         "Ketchikan";  % 7
         "Kodiak   ";  % 8
         "Eagle    "]; % 9
N = size(names,1);
D = zeros(N,N);
D(1,2) = 259;  D(1,3) = 557;  D(1,4) = 728;  D(1,5) = 560;  D(1,6) = 811;  D(1,7) = 751;  D(1,8) = 260;  D(1,9) = 353;
               D(2,3) = 627;  D(2,4) = 503;  D(2,5) = 524;  D(2,6) = 997;  D(2,7) = 852;  D(2,8) = 511;  D(2,9) = 190;
                              D(3,4) = 1098; D(3,5) = 1103; D(3,6) = 1271; D(3,7) = 230;  D(3,8) = 667;  D(3,9) = 499;
                                             D(4,5) = 517;  D(4,6) = 1234; D(4,7) = 1328; D(4,8) = 940;  D(4,9) = 600;
                                                            D(5,6) = 732;  D(5,7) = 1308; D(5,8) = 633;  D(5,9) = 713;
                                                                           D(6,7) = 1384; D(6,8) = 608;  D(6,9) = 1152;
                                                                                          D(7,8) = 805;  D(7,9) = 729;
                                                                                                         D(8,9) = 608;

% symmetric square distance matrix
D2 = (D+D').^2;

% "centering" makes D2 into a matrix which is a product B = X' X, i.e. entries
%    of B are inner products
one = ones(N,1); % column matrix of 1
H = eye(N) - (1/N) * one * one';
B = - 0.5 * H * D2 * H';

usesvd = false;
if usesvd
  [X, L, V] = svd(B);
else
  [X, L] = eig(B);
end
figure(1)
semilogy(abs(diag(L)),'o','markersize',16)
axis([1 N 1 10*max(max(D^2))]), grid on
title('eigenvalues: two largest are for map embedding')

fixup = false;
if fixup
  X(:,1) = X(:,1) / sign(X(7,1));    % reflect so Ketchican has x-value positive
  X(:,2) = X(:,2) / sign(X(4,2));    % reflect so Barrow has y-value positive
  Z = cross([X(4,1); X(4,2); 0], [0; norm(X(4,1:2)); 0]) / (norm(X(4,1:2))^2);
  theta = asin(Z(3));
  rot = [cos(theta), -sin(theta); sin(theta), cos(theta)];
  for j=1:N, X(j,1:2) = X(j,1:2) * rot'; end
end

figure(2),  plot(X(:,1),X(:,2),'*','markersize',14)
hold on
for j = 1:N
  text(X(j,1)-0.05,X(j,2)+0.05,names(j,:))
end
hold off,  axis equal,  axis off
title('eigenvectors of two largest eigenvalues give map coordinates')

