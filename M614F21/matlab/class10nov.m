function U = class10nov
% CLASS10NOV  This LU with partial pivoting example generates
% the upper triangular matrix U using "by-hand in Matlab"
% row operations.

A = [  1   2   1   2;
      -1   0  -4  -1;
       2   4   0   4;
       1   8 -10   6];
U = A;                  % make a copy

% stage 1:  |u_31| = max |u_i1|
tmp = U(1,:);  U(1,:) = U(3,:);  U(3,:) = tmp;
U(2,:) = U(2,:) - (U(2,1)/U(1,1)) * U(1,:);
U(3,:) = U(3,:) - (U(3,1)/U(1,1)) * U(1,:);
U(4,:) = U(4,:) - (U(4,1)/U(1,1)) * U(1,:);
showU(1)

% stage 2:  |u_42| = max |u_i2|
tmp = U(2,:);  U(2,:) = U(4,:);  U(4,:) = tmp;
% u_32=0 already
U(4,:) = U(4,:) - (U(4,2)/U(2,2)) * U(2,:);
showU(2)

% stage 2:  |u_33| = max |u_i3|
% no row swap
U(4,:) = U(4,:) - (U(4,3)/U(3,3)) * U(3,:);
showU(3)

    function showU(stage)
        fprintf('U after stage %d:\n',stage)
        fprintf(' %9.5g %9.5g %9.5g %9.5g\n',U')
    end
end
