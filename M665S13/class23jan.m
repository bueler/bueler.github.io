% CLASS23JAN  Runnable history of the commands I used in my Math 665 class
% on 23 January 2013.

% generate a 4x4 magic square and check column and row sums
A = magic(4)
sum(A)              % column sums
A'                  % matrix transpose
sum(A')             % row sums
inv(A)              % fails; A is not invertible

% bigger random matrix; extract pieces
A = rand(8)
A(:,3)              % third column
A(1:3,1:3)          % 3x3 upper left corner
A([1 3 5],[1 3 5])  % a different 3x3 extract

% extract entries
B = [3 4 7; 2 3 5; 5 6 7];  % semicolon means no output
B(1,3)              % an entry
name = 'bueler'     % strings are also matrices in Matlab
name(1,4)           % an entry
size(B)             % output is [rows cols]
size(name)          % ditto

% matrix multiplication (and compatible sizes
x = (1:8)'
size(x)
size(A)
x = (1:8)'
A * x               % works
%x * A              % illegal
%A * B              % illegal

% you can plot vectors
figure(1)
y = A * x
plot(x,y)           % plot in default style

% making useful plots: use fine grid
figure(2)
x = 1:.01:8;        % fine grid
plot(x,sin(x),'r','linewidth',2.0) % red and thicker line
%help plot          % get more info

% decorated plot
figure(3)
x = 1:8;
plot(x,sin(x),'r-*','markersize',16,'linewidth',3.0)
xlabel('x in meters')
ylabel('y in parsecs')
grid on
hold on
plot(x,cos(x),'g')  % green
hold off

% legal matrix ops
B
inv(B)
det(B)
B^2
B^(-1)

% legal entry-wise ops
B.^2
exp(B)

% more legal matrix ops
C = hilb(3)*30      % generate a 3x3 matrix another way
B * C               % matrix product
B .* C              % entrywise product; different from B * C
B + C               % unambiguous

% size matters
x = 1:8;
%x^2                % illegal to multiply by itself as a matrix
x*x'                % dot (inner) product with itself
x.^2                % entrywise square

% assigment versus logical comparison
x = 2               % assignment
x = x^2             % assignment
x == x^2            % is x equal to x^2?  (gives true=1 or false=0)
x < x^2
x ~= x^2            % equivalent that works in octave: x != x^2

% enter linear system   A v = b   as an augmented matrix
A = [1 8 2; 1 -1 -1; 2 3 1]
b = [5 -1 4]'
Ab = [A b]
%Ab = [A; b]  % error: wrong sizes

% do Gaussian elimination "by-hand-in-Matlab"; watch each row operation
Ab(2,:) = Ab(2,:) - 1*Ab(1,:)
Ab(3,:) = Ab(3,:) - 2*Ab(1,:)
Ab(3,:) = Ab(3,:) - (Ab(3,2)/Ab(2,2)) * Ab(2,:)
format rat          % show as rationals to check by-hand work
Ab
format short

% complete back substitution
v(3) = Ab(3,4) / Ab(3,3)
v(2) = (Ab(2,4) - Ab(2,3)*v(3)) / Ab(2,2)
v(1) = (Ab(1,4) - Ab(1,2)*v(2) - Ab(1,3)*v(3)) / Ab(1,1)

% compare:
vv = A \ b

