% SINCOSTABLE  make a simple table with aligned numbers

fprintf('      x       sin(x)     cos(x)\n')
fprintf('--------------------------------\n')
for k = 0:12
  x = k * pi/6;
  fprintf(' %9.6f  %9.6f  %9.6f\n',x,sin(x),cos(x));
end
