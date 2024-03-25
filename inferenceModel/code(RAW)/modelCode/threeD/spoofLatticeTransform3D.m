% trueLattice = lattice;
% growthMag = 1.05*trueLattice(1:end/3);
% anisotropy = pi*(trueLattice(1+end/3:2*end/3) - 0.5);
% trueLattice = [trueLattice(1:end/3) + trueLattice(1:end/3).*growthMag.*cos(anisotropy) ,trueLattice(1+end/3:2*end/3) + trueLattice(1+end/3:2*end/3).*sqrt(growthMag).*sin(anisotropy),trueLattice(1+2*end/3:end)];

% trueLattice = lattice;
% growthMag = 1.005*trueLattice(1:end/2);
% anisotropy = 0;
% trueLattice = [trueLattice(1:end/2) + trueLattice(1:end/2).*growthMag.*cos(anisotropy) ,trueLattice(1+end/2:end)];
trueLattice = lattice;
% trueLattice(1:size(lattice,2)/3) = trueLattice(1:size(lattice,2)/3) + 5;
% trueLattice(1:size(lattice,2)/3) = trueLattice(1:size(lattice,2)/3).*log(trueLattice(1:size(lattice,2)/3));
% trueLattice(1+size(lattice,2)/3:2*size(lattice,2)/3) = trueLattice(1+size(lattice,2)/3:2*size(lattice,2)/3)+1.5*(trueLattice(1+size(lattice,2)/3:2*size(lattice,2)/3)-min(object.vertices(:,2)));
% trueLattice(1:size(lattice,2)/3) = trueLattice(1:size(lattice,2)/3)+1.5*(trueLattice(1:size(lattice,2)/3)-min(object.vertices(:,1)));


% trueLattice(1:size(lattice,2)/3) = trueLattice(1:size(lattice,2)/3)+trueLattice(1:size(lattice,2)/3).*((((0.5-0.001*(trueLattice(1+end/3:2*end/3)-25).^2)>0).*(0.5-0.001*(trueLattice(1+end/3:2*end/3)-25).^2))+(((0.5-0.001*(trueLattice(1+end/3:2*end/3)-62).^2)>0).*(0.5-0.001*(trueLattice(1+end/3:2*end/3)-62).^2))).*(( trueLattice(1:size(lattice,2)/3)-minX)/(maxX-minX) );
clear temp
temp = size(trueLattice,2)/3;
trueLattice = [trueLattice(1:temp),trueLattice(temp+1:2*temp),trueLattice(2*temp+1:end) + trueLattice(2*temp+1:end).*((((0.5-0.00001*(trueLattice(1:temp)-275).^2)>0).*(0.5-0.00001*(trueLattice(1:temp)-275).^2)*2)+(((0.5-0.00001*(trueLattice(1:temp)-650).^2)>0).*(0.5-0.00001*(trueLattice(1:temp)-650).^2))).*(( trueLattice(1:temp)-minX)/(maxX-minX) )];
clear temp

% trueLattice(f1(lattice(f1+N) == 0)) = trueLattice(theta(lattice(theta+N) == object.resolution(2)));
% trueLattice(f1(ismembertol(lattice(f1+N),object.resolution(2)*(rows-1)))) = trueLattice(theta(lattice(theta+N) == object.resolution(2)*(rows-2)));