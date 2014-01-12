function braille(s)
% BRAILLE  Converts a string to braille and shows as dots on the screen.
% Example: >> braille('this is a test')

b = [1 0 0 0 0 0; % a
     1 0 1 0 0 0; % b
     1 1 0 0 0 0; % c
     1 1 0 1 0 0; % d
     1 0 0 1 0 0; % e
     1 1 1 0 0 0; % f
     1 1 1 1 0 0; % g
     1 0 1 1 0 0; % h
     0 1 1 0 0 0; % i
     0 1 1 1 0 0; % j
     1 0 0 0 1 0; % k
     1 0 1 0 1 0; % l
     1 1 0 0 1 0; % m
     1 1 0 1 1 0; % n
     1 0 0 1 1 0; % o
     1 1 1 0 1 0; % p
     1 1 1 1 1 0; % q
     1 0 1 1 1 0; % r
     0 1 1 0 1 0; % s
     0 1 1 1 1 0; % t
     1 0 0 0 1 1; % u
     1 0 1 0 1 1; % v
     0 1 1 1 0 1; % w
     1 1 0 0 1 1; % x
     1 1 0 1 1 1; % y
     1 0 0 1 1 1]; % z

% converts letters to indices into b()
s = upper(s); % ignor case by making it upper
s = s - 64;  % converts to number and makes A=1,...,Z=26
s(s<1) = 0;  % everything below A is a space
s(s>26) = 0; % everything above Z is a space

% convert the string to braille and put it into a
%   big matrix of ones and zeros
M = zeros(9,3*length(s));
for i=1:length(s)
  letter = zeros(3,3); % is a space until we modify it
  if s(i) > 0
    letter(:,1:2) = reshape(b(s(i),:),2,3)';  % use array b() to get braille
  end
  M(4:6,3*(i-1)+1:3*(i-1)+3) = letter; % letters go in middle three lines
end                                    %   of white space

% put the line of braille across the top of the screen
% octave is screwed up w.r.t. some figure controls; this shows how to
%   write different code that works for both
screen = get(0,'screensize');
if exist('OCTAVE_VERSION','builtin') > 0
  figure(1), close(1)
  figure(1,'position',[screen(3:4) screen(3:4)].*[0.1 0.75 0.85 0.2])
  spy(M,6,'o'), axis off
else % use matlab: this is the intended way
  spy(M,6,'o'), axis off
  set(gcf,'position',[screen(3:4) screen(3:4)].*[0.1 0.75 0.85 0.2])
end

