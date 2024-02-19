trueLattice = lattice;
growthMag = 1.05*trueLattice(1:end/2);
anisotropy = pi*(trueLattice(1+end/2:end) - 0.5);
trueLattice = [trueLattice(1:end/2) + trueLattice(1:end/2).*growthMag.*cos(anisotropy) ,trueLattice(1+end/2:end) + trueLattice(1+end/2:end).*sqrt(growthMag).*sin(anisotropy)];

% trueLattice = lattice;
% growthMag = 1.005*trueLattice(1:end/2);
% anisotropy = 0;
% trueLattice = [trueLattice(1:end/2) + trueLattice(1:end/2).*growthMag.*cos(anisotropy) ,trueLattice(1+end/2:end)];