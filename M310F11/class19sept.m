% CLASS19SEPT   Commands from in-class Matlab/Octave demonstrations on Monday
%               19 Sept.  It is probably best to cut and paste one command at
%               a time and see what it does.

% INTRO TO PLOT

help plot                               % information on command

plot([1 2 3],[1 4 9])                   % approximate plot of y=x^2 on [1,3]
plot([1 1.5 2 2.5 3],[1 2.25 4 6.25 9]) % better
x=1:0.1:3;  plot(x,x.^2)                % even better (smoother)


% USE PLOT TO FIND WHERE TWO CURVES CROSS; SEE P1 ON ASSIGNMENT # 1

x=-5:0.01:5;
size(x)                                 % list of 1001 points
plot(x,exp(-x),x,x^2)                   % SYNTAX ERROR!
plot(x,exp(-x),x,x.^2)                  % what you wanted
legend('e^{-x}','x^2')
xlabel x
axis([-5 5 0 10])

axis([0 1 0 1])                         % show just the part that is useful
grid on


% DO BISECTION "BY HAND"

a = 0; b = 1;
x = (a+b)/2;  f = x^2 - exp(-x)
a = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
a = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
a = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
a = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
b = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]
a = x;
x = (a+b)/2;  f = x^2 - exp(-x);  [a b x f]

format long                            % show enough digits to know where we got
[a b x f]


% IN-LINE LOOPS (JUST FOR PLAY)

for n=1:13, 2+2, end
for n=1:13, n^2, end


% COMMANDS TO KNOW WHERE YOU ARE, ETC.

pwd                                    % print working directory
ls *.m                                 % list files

