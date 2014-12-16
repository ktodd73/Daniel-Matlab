function lens = map10100100
% ZEMAX/THORLABS/ZMX/MAP10100100-A.ZMX - 1 Inch Matched Achromatic Pair, Magnification: 1.00:1.00

lens.fn = 'map10100100';
lens.name = 'MAP10100100-A';
lens.diam = [ 25.4, 25.4, 25.4, 21.2122136221, 25.4, 25.4, 25.4 ];
lens.glass = { @sf5, @nbk7, @(x) (1), @(x) (1), @nbk7, @sf5 };
lens.curv = [ 0.0077984870935039, 0.0218770509735288, -0.0159362549800797, 0, 0.0159362549800797, -0.0218770509735288, -0.0077984870935039 ];
lens.tc = [ 2.5, 4, 2.000003911963, 1.998219298495, 4, 2.5 ];
lens.conj = [ 97.68949384491, 95.79529808973];
lens.conjcurv = [ 0, 0];
