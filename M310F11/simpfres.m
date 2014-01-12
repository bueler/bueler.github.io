function z = simpfres(h,N)
% SIMPFRES  Print table of values of the Fresnel cosine function
%          /x
%   C(x) = |  cos(pi t^2/2) dt
%          /0
% at the values
%   x = 0,h,2h,...,Nh.
% Also returns the values C(x) as a vector of length N+1.
% Example:  >> simpfres(0.1,20);      % our table of 21 values

if h <= 0, error('h must be positive'); end
if N < 0, error('N must be at least 0'); end
x = 0:h:N*h;
z = zeros(size(x));                % note z(1)=0 already: C(0)=0

fprintf('       x           C(x)\n')
fprintf('  0.000000000  0.000000000\n')  % answers known already
for m = 1:N                        % loop through points x(m)
  hh = h / 8;                      % we compute S_8(f) for each
  tt = x(m):hh:x(m+1);             %     subinterval
  c = [1 4 2 4 2 4 2 4 1];
  S = (hh/3) * c * cos(pi * tt.^2 / 2)';
  z(m+1) = z(m) + S;               % next entry in table
  fprintf('  %.9f  %.9f\n',x(m+1),z(m+1))  % format: 9 digits
end
