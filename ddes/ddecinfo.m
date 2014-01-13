function ans = ddecinfo(dfcn,eps0,opt)
% DDECINFO(dfcn,eps0)
%  -Looks to the coefficients specified by descriptor function dfcn, with
%   parameters eps0, then displays them graphically.
%       dfcn = function_handle of desired descriptor function
%       eps0 = parameters to be used in handling the DDE
%   Descriptors not requiring parameter inputs may be called by ddecinfo
%   by either supplying only one input argument, or by using eps0=[].
%  -User may also utilize options 'legoff' (disabling the legend) and
%   'timeline' (producing a separate figure containing a timeline) by
%   calling ddecinfo(dfcn,eps0,opt).

% BFW 7/28/04

% descriptor information

c = dfcn(-1,0,eps0);
L = c(1); n = c(2); tau = c(3); d = c(4);

% error handling

% parameters
if nargin==1 & d~=0,
    error('descriptor requires parameters'),
elseif nargin~=1 & d==0 & ~isempty(eps0),
    warning('descriptor does not require parameters')
elseif nargin~=1 & d~=length(eps0),
    error('incorrect # of parameters'), end

% handles options/creates variables

if nargin==3 & strcmp(opt,'legoff'), legendon=false;
else legendon=true; end

if nargin==3 & strcmp(opt,'timeline'), timlinon = true;
else timlinon = false; end

col = max(ceil(sqrt(L+1)),2);       % defines dimension of subplots
row = ceil((L+1)/col);

if ~exist('eps0'), eps0 = []; end       % creates an eps0 if it DNE

% define visual options

prec = 200;         % higher value -> more accurate plots
horispac = L*tau/200;       % controls horizontal buffer on plots
vertspac = .1;      % controls vertical buffer on plots (proportionally)
rcspacer = ',';     % inserts string to separate indices
legndnum = [int2str(repmat(1:n,1,n)'), repmat(rcspacer,n^2,1), ...
    int2str(reshape(repmat((1:n)',1,n)',n^2,1))];  % creates index template
% saves plot options to reset after program completion
dafs = get(0,'defaultaxesfontsize'); dalw = get(0,'defaultaxeslinewidth');
dllw = get(0,'defaultlinelinewidth'); uni = get(gcf,'Units');
set(0,'defaultaxesfontsize',12,'defaultaxeslinewidth',.7,...
    'defaultlinelinewidth',.8)

% compute coeff.s
ti = -horispac; tf = L*tau+horispac; t = linspace(ti,tf,prec);
figure(1)
for pos = 0:L
    subplot(row,col,pos+1)
    for k = 1:prec
        A(:,:,k) = dfcn(pos,t(k),eps0); end
    Ar = reshape(A,n^2,prec);

    % plot non-zero coeff.s
    Afind = find(any(Ar'));
    Aplot = Ar(Afind,:);
    if ~isempty(Afind), zeroflag = false; plot(t,Aplot),
    else zeroflag = true; plot(t,zeros(1,prec)), end

    % display legend
    if legendon & ~zeroflag
        legndsiz = length(Afind);
        if legndsiz>3, warning(['Legend is rather large, consider' ...
                'utilizing ''legoff'' option']), end
        legnd = [legndnum(Afind,:) repmat(['}'],legndsiz,1)];
        if ~pos     % displays appropriate legend and title
            legend([repmat(['A' '_{'],legndsiz,1) legnd])
        else
            legend([repmat(['(B_{' int2str(pos) '})_{'],legndsiz,1) legnd])
        end, end

    % display title
    if zeroflag, suf = ' [all zero]'; else suf = ''; end
    if ~pos, title(['coeff. of y(t)' suf])
    else title(['coeff. of y(t-' int2str(pos) '*\tau)' suf]), end

    % define display limits
    minA =  min(min(Aplot)); maxA = max(max(Aplot));
    if zeroflag, minA=0; maxA=0; Adelt=1;                  % zero coeff
    elseif maxA-minA<realmin, Adelt = abs(vertspac*maxA);  % constant coeff
    else Adelt = vertspac*(maxA-minA); end
    axis([ti tf minA-Adelt maxA+Adelt])

    % define horiz. ticks in terms of tau
    set(gca,'XTick',0:tau:L*tau)
    set(gca,'XTickLabel',[[' ';' ';int2str([2:L]')] ...
        [' 0 ';repmat('tau',L,1)]])
end

% draw timeline
if timlinon
    figure(2), set(gcf,'Units','normalized','Position',[.125,.375,.75,.25])
    plot([ti tf],[0 0])
    axis([ti tf -1 1])
    set(gca,'XTick',0:tau:L*tau,'YTick',[])
    set(gca,'XTickLabel',[[' ';' ';int2str([2:L]')] ...
        ['      ';repmat('tau = ',L,1)] get(gca,'XTickLabel')])
    title('timeline')
end

% final steps

set(0,'defaultaxesfontsize',dafs,'defaultaxeslinewidth',dalw,...
    'defaultlinelinewidth',dllw), set(gcf,'Units',uni)
disp(['Descriptor function appears to be valid.'])

% last updated: July 27, 2004
