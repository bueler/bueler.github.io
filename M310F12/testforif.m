% TESTFORIF  testing programming constructs

for i = 1:20
  factorial(i)
end

for i = 1:20
  if mod(i,3) == 0   % equality comparison
    % to know more, type 'fprintf' in google
    % fprintf is a C command inherited into Matlab
    fprintf('%d is divisible by 3\n',i)
  end
end


for i = 1:20
  if mod(i,3) > 0   % inequality comparison
    % to know more, type 'fprintf' in google
    % fprintf is a C command inherited into Matlab
    fprintf('%d is not divisible by 3\n',i)
  end
end
