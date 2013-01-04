function str = d_highdimcell(v, ind, rest, maxlines)

if nargin<3
  rest = '';
end

if nargin<4
  maxlines = d_MAXLINES;
end
cut = 0;

S = size(v);
S1 = S(3:end);
L = length(S1);
fmt = sprintf('%%%is', ind*2);
inds = sprintf(fmt, '');
str='';

if L==0
  str = [ inds '(:,:,1' rest "):\n" ];
  str = [ str d_cell(v, ind+1)];
elseif L>1
  S0 = S1(1:end-1);
  vv = reshape(v, [S(1:2) prod(S0) S1(end)]);
  for k=1:S1(end)
    v_ = reshape(vv(:,:,:,k), [S(1:2) S0]);
    add = d_highdimcell(v_, ind+1, sprintf(',%i%s', k, rest), maxlines-2);
    if length(find(str=="\n")) + length(find(add=="\n")) >= maxlines
      str = [ str inds "...\n" ];
      cut = 1;
      break;
    else
      str = [str add];
      if k<S1(end) && any(S1(1:end-1)>1)
	str = [ str "\n"];
      end
    end
  end
else
  for k=1:S1(end)
    add = [ inds sprintf('(:,:,%i',k) rest "):\n" ];
    add = [ add d_cell(v(:,:,k), ind+1, maxlines-2) ];
    if length(find(str=="\n")) + length(find(add=="\n")) >= maxlines
      str = [ str inds "...\n" ];
      cut = 1;
      break;
    else
      str = [str add];
    end
  end
end
if cut && nargin<4
  str = [ str inds "(" d_size(v) ")\n" ];
end
