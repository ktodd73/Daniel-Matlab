function y = modg_extend(par)
% y=MODG_EXTEND(par) returns par unchanged, except that a new cluster
% with p=0, mu=0, sig=1 is added.
% Input: par: as for mog_fullem
% Output: as input
% Coding: DW

K = length(par.p);
D = size(par.mu,1);
y.p = cat(2,par.p,[0]);
y.mu = cat(2,par.mu,zeros(D,1));
for k=1:K
  y.sig{k} = par.sig{k};
end
y.sig{K+1} = ones(D,1);
