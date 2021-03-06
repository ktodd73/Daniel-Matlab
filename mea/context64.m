function ctxt = context64(tms, rawfn, npre, npost, chs)
% CONTEXT64 - Wrapper around MEABench's context64
%    ctxt = CONTEXT64(tms, rawfn), where TMS is a vector of timestamps, 
%    and RAWFN is the name of a MEABench raw file, extracts context around
%    each event.
%    Alternatively, if RAWFN is a cell array containing a string and an
%    integer, this is used to parse input for CONTEXTNI.
%    ctxt = CONTEXT64(tms, rawfn, npre, npost, chs) overrides the default of
%    125 scans pre and post the event's time and specifies a set of
%    hw channels to extract.
%    Note that the event's time is specified in scans and although it may 
%    not be integer, we do not interpolate. Rather, the time is rounded to
%    the nearest scan before calling the executable.
%    Output is shaped TxMxC where T is the length of context in scans, M
%    is the number of events, and C is the number of channels

if nargin<3
  npre = 125;
end
if nargin<4
  npost = npre;
end
if nargin<5
  chs=[0:63];
end

M = length(tms);

sfn = tempname;
fd = fopen(sfn, 'w');
for m=1:M
  fprintf(fd, '%i', round(tms(m)));
  for k=chs(:)'
    fprintf(fd, ' %i', k);
  end
  fprintf(fd,'\n');
end
fclose(fd);

if iscell(rawfn)
  nch = rawfn{2};
  rawfn = rawfn{1};
else
  nch = [];
end

if isempty(nch) & endswith(rawfn, 'bin')
  error('A non-interleaved binary file cannot be read without channel count');
end

% Now run context64/ni
cfn = tempname;
if isempty(nch)
  r = unix(sprintf('mea context64 -i %s -o %s -t -p %i -P %i %s', ...
      sfn, cfn, npre, npost, rawfn));
  if r
    error(sprintf('context64 failed to complete (%i)',r));
  end
else
  r = unix(sprintf('mea contextni -i %s -o %s -t -p %i -P %i -c %i %s', ...
      sfn, cfn, npre, npost, nch, rawfn));
  if r
    error(sprintf('contextni failed to complete (%i)',r));
  end
end
delete(sfn);

% Load context
fd = fopen(cfn, 'rb');
ctxt = fread(fd,[1 inf], 'int16');
fclose(fd);
%delete(cfn);

C=length(chs);
T=npre+npost;

if isempty(nch)
  ctxt = reshape(ctxt, [C T M]);
  ctxt = permute(ctxt, [2 3 1]);
else
  ctxt = reshape(ctxt, [T C M]);
  ctxt = permute(ctxt, [1 3 2]);
end

