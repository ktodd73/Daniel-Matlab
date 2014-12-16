function trc = tracer_trace(trc, wl)
% TRACER_TRACE - Applies tracer object
%    trc = TRACER_TRACE(trc, lambda) traces rays emanating from
%    the object contained in TRC. LAMBDA is wavelength in
%    nanometers.
%    XX and YY will be NxYxT where N is the number of surfaces plus 2,
%    Y is the number of points in the object, and T is the number of rays
%    from each point.

x0 = trc.objx;
if ~trc.placed
  trc = tracer_placelenses(trc, wl);
end

for y=1:length(trc.objyy)
  for t=1:length(trc.objth)
    [xx(:,y,t), yy(:,y,t), y1(y,t), tantheta1(y,t)] = ...
	tracer_sphereray(trc.objx, trc.objyy(y), trc.objth(t), ...
        trc.x_surf, trc.r_surf, trc.dn_surf);
  end
end

trc.xx = xx;
trc.yy = yy;
trc.y1 = y1;
trc.tantheta1 = tantheta1;