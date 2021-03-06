function [xx, yy, y1, tantheta1] = tracer_sphereray(x0, y0, th0, ...
    x_surf, r_surf, dn_surf)
% TRACER_SPHERERAY - Trace a single ray past several spherical surfaces
%    [xx,yy] = TRACER_SPHERERAY(x0, y0, phi0,  x_surf, r_surf, dn_surf) traces
%    a single ray departing from (X0,Y0) in the direction PHI0 past several
%    spherical surfaces on the y=0 axis at X_SURF. Each surface has radius
%    of curvature R_SURF (positive if bulge faces left) and represents a
%    relative change in refractive index DN_SURF. Note that X_SURF are the
%    coordinates where the surfaces hit the optical axis, not the center
%    of the sphere.
%    For instance, for a simple positive lens, one might have
%       x_surf = [10 15];
%       r_surf = [50 -50];
%       dn_surf = [1.5 1/1.5];
%    The trace is extended until a final crossing of the optical axis or to inf.
%    [xx, yy, y1, tantheta] = TRACER_SPHERERAY(...) also returns the direction
%    information of the final ray.
%    An ideal lens may be represented by storing its focal length in R_SURF
%    and NaN in DN_SURF.

xx = x0;
yy = y0;

% First, convert to [y,tan(theta)] coordinates:
tantheta1 = tan(th0);
if tantheta1==0
  y1 = y0;
else
  y1 = y0 - x0*tantheta1;
end
%[x0, y0, th0, tantheta1, y1]

% Now, for each surface:
K=length(x_surf);
for k=1:K
  if isnan(dn_surf(k))
    xcross = x_surf(k);
    ycross = y1 + xcross*tantheta1;
    
    xx = [xx; xcross];
    yy = [yy; ycross];
    
    if tantheta1==0
      % collimated ray, will go to y=0 at x = x_surf + f
      % Recall that f is stored in r_surf.
      xx = [xx; xcross + r_surf(k)];
      yy = [yy; 0];
      tantheta1 = -ycross ./ r_surf(k);
      y1 = ycross - xcross*tantheta1;
    else
      % A ray parallel to this but at ycross=0 would go straight, obviously.
      % It would reach x = x_surf + f at y = f*tan(theta).
      % Our ray goes there too.
      xx = [xx; xcross + r_surf(k)];
      yy = [yy; r_surf(k)*tantheta1];
      % After that the angle is
      tantheta1 = (yy(end) - ycross) ./ r_surf(k);
      % and it appears to come from
      y1 = ycross - xcross*tantheta1;
      % Note that the tantheta==0 case could be subsumed in this, rather
      % trivially. I am leaving it as written because it is easier to
      % read that way.
    end
  else
    if isinf(r_surf(k))
      xcross = x_surf(k);
      ycross = y1 + xcross*tantheta1;
      sinphi = 0;
    else
      % Calculate intersection
      % See C4 p85.
      q = y1+(x_surf(k)+r_surf(k))*tantheta1;
      D = q^2 + (1+tantheta1^2)*(r_surf(k)^2*tantheta1^2-q^2);
      rsinphi = (q -sign(tantheta1)*sign(r_surf(k))*sqrt(D))/(1+tantheta1^2);
      ycross = rsinphi;
      sinphi = rsinphi/r_surf(k);
      xcross = x_surf(k)+r_surf(k) - r_surf(k)*cos(asin(sinphi));
    end
    xx = [xx; xcross];
    yy = [yy; ycross];
  
    % Now, what is the angle of incidence?
    alpha = atan(tantheta1)+asin(sinphi);
    alpha1 = asin(sin(alpha)/dn_surf(k));
    tantheta1 = tan(-asin(sinphi)+alpha1);
    y1 = ycross - xcross*tantheta1;
  end
end

if tantheta1==0
  xx = [xx; inf];
  yy = [yy; y1];
else
  xx = [xx; -y1/tantheta1];
  yy = [yy; 0];
end
