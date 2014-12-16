function lens = map1050100
% ZEMAX/THORLABS/ZMX/MAP1050100-A.ZMX - 1 Inch Matched Achromatic Pair, Magnification: 1.00:2.00

lens.fn = 'map1050100';
lens.name = 'MAP1050100-A';
lens.diam = [ 25.4, 25.4, 25.4, 20.76373647462, 25.4, 25.4, 25.4 ];
lens.glass = { @sf10, @nbaf10, @(x) (1), @(x) (1), @nbk7, @sf5 };
lens.curv = [ 0.0034355996839248, 0.0448833034111311, -0.02999400119976, 0, 0.0159362549800797, -0.0218770509735288, -0.0077984870935039 ];
lens.tc = [ 2.5, 9, 1.708257442652, 2.000001552937, 4, 2.5 ];
lens.conj = [ 43.44244166781, 95.13952332575];
lens.conjcurv = [ 0, 0];
