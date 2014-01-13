function options = ddecset(varargin)
%DDECSET Create/alter DDEC OPTIONS structure.
%   OPTIONS = DDECSET('NAME1',VALUE1,'NAME2',VALUE2,...) creates an
%   options structure OPTIONS in which the named properties have
%   the specified values.  Any unspecified properties have default values.
%   It is sufficient to type only the leading characters that uniquely
%   identify the property.  Case is ignored for property names.
%   
%   OPTIONS = DDECSET(OLDOPTS,'NAME1',VALUE1,...) alters an existing options
%   structure OLDOPTS.
%   
%   OPTIONS = DDECSET(OLDOPTS,NEWOPTS) combines an existing options structure
%   OLDOPTS with a new options structure NEWOPTS.  Any new properties
%   overwrite corresponding old properties.
%   
%   DDECSET with no input arguments displays all property names and their
%   possible values.
%   
%DDECSET Properties (possible options):
%   
%AbsTol - Absolute error tolerance  [ positive scalar ]
%   Tolerance applies to all components of the solution vector.
%   AbsTol defaults to 1e-6 in all solvers.
%  
%Disp - Flag for DDECSPECT to display diagnostic information [ {'on'} | 'off' ]
%
%DrawChart - Flag for DDECSPECT to draw a stability chart [ {'on'} | 'off' ]
%
%DrawSoln - Flag for DDECIVP to plot solution [ {'on'} | 'off' ]
%
%ChartType1D - Stability chart style for DDECSPECT if d=1 parameters [ {1} | 2 3 4 5 ]
%
%ChartType2D - Stability chart style for DDECSPECT if d=2 parameters [ {1} | 2 3 4 5 ]
%
%ChartType3D - Stability chart style for DDECSPECT if d=3 parameters [ {1} | 2 3 4 5 ]
%
%SpectRad - Flag for DDECU to return only spectral radius [ 'on' | {'off'} ]
%

%   Names=DDECSET(-1) is used by DDECGET.

%   DDECSET is a modification of the DDESET, which is a modification of ODESET 
%   function written by Mark W. Reichelt and Lawrence F. Shampine.


% Print out possible values of properties.
if (nargin == 0) & (nargout == 0)
  fprintf('          AbsTol: [ positive scalar {1e-6} ]\n');
  fprintf('            Disp: [ {on} | off ]\n');
  fprintf('       DrawChart: [ {on} | off ]\n');
  fprintf('        DrawSoln: [ {on} | off ]\n');
  fprintf('     ChartType1D: [ {1} | 2 | 3 | 4 | 5 ]\n');
  fprintf('     ChartType2D: [ {1} | 2 | 3 | 4 | 5 ]\n');
  fprintf('     ChartType3D: [ {1} | 2 | 3 | 4 | 5 ]\n');
  fprintf('        SpectRad: [ on | {off} ]\n');
  fprintf('\n');
  return;
end

Names = [
         'AbsTol      '
         'Disp        '
         'DrawChart   '
         'DrawSoln    '
         'ChartType1D '
         'ChartType2D '
         'ChartType3D '
         'SpectRad    '
                       ];
[m,n] = size(Names);
names = lower(Names);

% used by ddecget to get Names
if (nargin==1)&(varargin{1}(1)==-1), options=Names; return, end 

% Combine all leading options structures o1, o2, ... in ddecset(o1,o2,...).
options = [];
for j = 1:m
  eval(['options.' Names(j,:) '= [];']);
end
i = 1;
while i <= nargin
  arg = varargin{i};
  if isstr(arg)                         % arg is an option name
    break;
  end
  if ~isempty(arg)                      % [] is a valid options argument
    if ~isa(arg,'struct')
      error(sprintf(['Expected argument %d to be a string property name ' ...
                     'or an options structure\ncreated with DDECSET.'], i));
    end
    for j = 1:m
      if any(strcmp(fieldnames(arg),deblank(Names(j,:))))
        eval(['val = arg.' Names(j,:) ';']);
      else
        val = [];
      end
      if ~isempty(val)
        eval(['options.' Names(j,:) '= val;']);
      end
    end
  end
  i = i + 1;
end

% A finite state machine to parse name-value pairs.
if rem(nargin-i+1,2) ~= 0
  error('Arguments must occur in name-value pairs.');
end
expectval = 0;                          % start expecting a name, not a value
while i <= nargin
  arg = varargin{i};
    
  if ~expectval
    if ~isstr(arg)
      error(sprintf('Expected argument %d to be a string property name.', i));
    end
    
    lowArg = lower(arg);
    j = strmatch(lowArg,names);
    if isempty(j)                       % if no matches
      error(sprintf('Unrecognized property name ''%s''.', arg));
    elseif length(j) > 1                % if more than one match
      % Check for any exact matches (in case any names are subsets of others)
      k = strmatch(lowArg,names,'exact');
      if length(k) == 1
        j = k;
      else
        msg = sprintf('Ambiguous property name ''%s'' ', arg);
        msg = [msg '(' deblank(Names(j(1),:))];
        for k = j(2:length(j))'
          msg = [msg ', ' deblank(Names(k,:))];
        end
        msg = sprintf('%s).', msg);
        error(msg);
      end
    end
    expectval = 1;                      % we expect a value next
    
  else
    eval(['options.' Names(j,:) '= arg;']);
    expectval = 0;
      
  end
  i = i + 1;
end

if expectval
  error(sprintf('Expected value for property ''%s''.', arg));
end
