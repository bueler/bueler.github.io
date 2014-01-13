function o = ddecget(options,name,default)
%DDECGET Get DDEC OPTIONS parameters.
%   VAL = DDECGET(OPTIONS,'NAME') extracts the value of the named property
%   from integrator options structure OPTIONS, returning an empty matrix if
%   the property value is not specified in OPTIONS.  It is sufficient to
%   type only the leading characters that uniquely identify the
%   property.  Case is ignored for property names.  [] is a valid OPTIONS
%   argument.
%   
%   VAL = DDECGET(OPTIONS,'NAME',DEFAULT) extracts the named property as
%   above, but returns VAL = DEFAULT if the named property is not specified
%   in OPTIONS.  For example
%   
%     val = ddecget(opts,'AbsTol',1e-4);
%   
%   returns val = 1e-4 if the AbsTol property is not specified in opts.

%   DDECGET is a modification of DDEGET which is a modification of the ODEGET 
%   function written by Mark W. Reichelt and Lawrence F. Shampine.  Note,
%   unlike DDEGET and ODEGET, DDECGET does not need to be modified for new
%   options.

if nargin < 2
  error('Not enough input arguments.');
end
if nargin < 3
  default = [];
end

if ~isempty(options) & ~isa(options,'struct')
  error('First argument must be an options structure created with DDECSET.');
end

if isempty(options)
  o = default;
  return;
end

% new feature means ddecget needs not be modified for new options
Names = ddecset(-1); 

[m,n] = size(Names);
names = lower(Names);

lowName = lower(name);
j = strmatch(lowName,names);
if isempty(j)               % if no matches
  error(sprintf(['Unrecognized property name ''%s''.  ' ...
                 'See DDECSET for possibilities.'], name));
elseif length(j) > 1            % if more than one match
  % Check for any exact matches (in case any names are subsets of others)
  k = strmatch(lowName,names,'exact');
  if length(k) == 1
    j = k;
  else
    msg = sprintf('Ambiguous property name ''%s'' ', name);
    msg = [msg '(' deblank(Names(j(1),:))];
    for k = j(2:length(j))'
      msg = [msg ', ' deblank(Names(k,:))];
    end
    msg = sprintf('%s).', msg);
    error(msg);
  end
end

if any(strcmp(fieldnames(options),deblank(Names(j,:))))
  eval(['o = options.' Names(j,:) ';']);
  if isempty(o)
    o = default;
  end
else
  o = default;
end
