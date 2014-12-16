function lens = al7560
% ZEMAX/THORLABS/ZMX/AL7560-A.ZMX - �75 mm, f=60 mm, NA=0.619, N-BK7 Aspheric Lens, ARC: 350-700 nm

lens.fn = 'al7560';
lens.name = 'AL7560-A';
lens.diam = [ 75, 57.967956252 ];
lens.glass = { @nbk7 };
lens.curv = [ 0.032605151613955, 0 ];
lens.tc = [ 35.5 ];
lens.conj = [ inf, 36.5065323571];
lens.conjcurv = [ 0, 0];
