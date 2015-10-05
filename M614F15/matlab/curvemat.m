function M = curvemat;
% CURVEMAT  Generate a matrix with a curve, for use as an image

M = zeros(200,200);
x = @(t) cos(t) + 0.1*t;
y = @(t) sin(t);
for t=-10:.01:10
   i = floor(50*x(t)+100);
   j = floor(70*y(t)+100);
   if (i >= 1) && (i <= 200) && (j >= 1) && (j <= 200)
     M(i,j) = 1;
   end
end

