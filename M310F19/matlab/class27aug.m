% CLASS27AUG   Runnable script (m-file) from in-class demonstration of Matlab.

% calculator functions
2+2
sin(5*pi)    % should be zero

% showing less or more digits
format short   % the default format
pi
format long
pi

% set a single variable and do a computation
x = 3
x^2-sin(5*x)

% plot a curve: choose a grid of x-values using colon notation and then plot
figure(1)
x = -5:.01:5;
y = x.^2-sin(5*x);  % need dotted operation (try without!)
plot(x,y)

% switch to coarser grid and plot in different style
figure(2)
x = -5:.5:5;
y = x.^2-sin(5*x);
plot(x,y,'o')

% generate random numbers, and extract parts by indexing with colon notation
z = randn(1,5)
z(2)
z(2:4)
z(1:2:end)

% enter matrices and do legal matrix operations
A = [1 3; 2 5];     % space as separator is o.k.
B = [-1,2; 1,0];    % commas as separator is o.k. too
A*B
A^2

% do entry-wise operations
A.^2
sin(A)
A.*B
A+B

% compute sum of vector z in three ways
% 1. built-in
s = sum(z)
% 2a. for loop (in one line)
s = 0; for n=1:5, s=s+z(n); end, s
% 2b. for loop with proper formating
s = 0;
for n = 1:5
    s = s + z(n);   % "=" is for assignment
end
s
% 3. dot product
s = z * ones(5,1)

% "==" is comparison for equality
r = 3.4;
if r == 3.5
    disp('success')
else
    disp('failure')
end

