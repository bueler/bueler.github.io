% CLASS17OCT  These are the commands I entered in class to
% demonstrate Gauss elimination.  There has been some editing
% for clarity.  You can run this as a script if STEPONEGE
% and FULLGE are in the same location.

% enter system as augmented matrix
M = [-1 6 1 -2; 4 2 0 4; 3 -2 5 -2]

% row operations "by hand on machine"
M(2,:) = M(2,:) + 4 * M(1,:)
M(3,:) = M(3,:) - (M(3,1) / M(1,1)) * M(1,:)
M(3,:) = M(3,:) - (M(3,2) / M(2,2)) * M(2,:)

% now do back substitution by hand
z = M(3,4) / M(3,3)
y = (M(2,4) - M(2,3)*z) / M(2,2)
x = (M(1,4) - M(1,2)*y - M(1,3)*z) / M(1,1)

% recreate A, b from same system; we'll run STEPONEGE on it
M = [-1 6 1 -2; 4 2 0 4; 3 -2 5 -2]
A = M(:,1:3)
b = M(:,4)
n = 3;
steponege

% again recreate A, b from same system; run FULLGE on it
A = M(:,1:3);
b = M(:,4);
fullge
% finally check our answer with \ on A, b from FULLGE
A \ b

