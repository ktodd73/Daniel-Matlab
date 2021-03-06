function clickspikes(spikefn, clickable)
% CLICKSPIKES(spikefn, clickable) lets the user click in the current
% figure, and if she clicks near a spike mentioned in CLICKABLE, the
% referenced spike context is read from SPIKEFN and displayed.
% SPIKEFN must be the name of a spikefile.
% CLICKABLE must be 3xN, the first column specifying x-coords, the
% second y-coords and the third spike indices.

fh=fopen(spikefn,'rb');

fprintf(2,'Click on a spike to see its context. Press a key to stop.\n');

k=waitforbuttonpress;
src=gca;
figure; dst=gcf;

while k==0
  b=axis;
  a=get(src,'CurrentPoint');
  x=a(1,1);
  y=a(1,2);
  tolx = (b(2)-b(1)) * .01;
  toly = (b(4)-b(3)) * .01;
  lox=x-tolx; hix=x+tolx;
  loy=y-toly; hiy=y+toly;
  idx=find(clickable(1,:)>lox & clickable(1,:)<hix & ...
      clickable(2,:)>loy & clickable(2,:)<hiy);
  if length(idx) == 0
    fprintf(2,'No spikes found near (%g,%g)\n',x,y);
  else
    cands=clickable(:,idx);
    dist=((cands(1,:)-x)/tolx).^2 + ((cands(2,:)-y)/toly).^2;
    [m idx]=min(dist);
    spikenr = cands(3,idx);
    plotspikecontext(fh,spikenr,dst);
  end
  k=waitforbuttonpress;
end

fclose(fh);

