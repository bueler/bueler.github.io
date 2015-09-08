% CLASS4SEPT   A history of commands I entered in the Math 614 class on
%              4 September.  If you run this it spews stuff which may not
%              make sense.  It is better to cut & paste into the command line.

2+2

help rand
rand(3,4)
rand(3)

v = rand(1,6)
2*v
plot(v)
plot(v,'ro')
plot(v,'rd','markersize',20)

x = 0:.01:10*pi;
size(x)
length(x)

y=sin(3*x);
plot(x,y)
axis([0 6 -1 1])

plot(x,rand(size(x)))

eye(3)

eig(rand(5))

rand(4)
A = ans
diag(A)
diag(diag(A))

B = [4 5 6]
B = [4 5 -6]
B = [4 5- 6]
B = [4 5 - 6]
B = [4, 5, - 6]

for k=1:8; rand(k), end

