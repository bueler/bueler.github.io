function C = circu(v)
% CIRCU   C = circu(v)
%   Generate a circulant matrix whose first column is the input 
%   vector v, treated as a column vector.

% can you predict what this will do before you run it?:
%   circu("bueler" - 100)
% explain!

if prod(size(v)) > length(v),  error('input v must be a vector'), end
m = length(v);

C=zeros(m,m);
for j=1:m
  for k=1:m
    C(j,k)=v(mod(j-k,m)+1);
  end
end

