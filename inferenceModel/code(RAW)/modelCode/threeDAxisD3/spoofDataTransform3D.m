
% growthMag = 1.05*X(1:end/3);
% anisotropy = pi*(X(1+end/3:2*end/3) - 0.5);
% x = [X(1:end/3) + X(1:end/3).*growthMag.*cos(anisotropy) ,X(1+end/3:2*end/3) + X(1+end/3:2*end/3).*sqrt(growthMag).*sin(anisotropy),X(1+2*end/3:end)];
% growthMag = 1.005*X(1:end/2);
% anisotropy = 0;
% x = [X(1:end/2) + X(1:end/2).*growthMag.*cos(anisotropy) ,X(1+end/2:end)];

% segmentX = object.vertices(:,1);
% segmentY = object.vertices(:,2);
% segmentZ = object.vertices(:,3);
% growthMag = 1.05*segmentX;
% anisotropy = pi*(segmentY - 0.5);
% 
% segmentXN = segmentX + segmentX.*growthMag.*cos(anisotropy);
% segmentYN = segmentY + segmentY.*sqrt(growthMag).*sin(anisotropy);
% segmentZN = segmentZ;
% objectN.faces = object.faces;
% objectN.vertices = [segmentXN,segmentYN,segmentZN]; % This might cause issues, need to see dimentions
% growthMag = 1.005*segmentX;
% anisotropy = 0;
% segmentXN = segmentX + segmentX.*growthMag.*cos(anisotropy);
% segmentYN = segmentY;
% N1 = size(X,2)/3;
% x = [X(1:N1).*log(X(1:N1)),X(N1+1:2*N1),X(2*N1+1:end)];
% X(1:N1) = X(1:N1) + 5;
% x(1:N1) = x(1:N1) + 5;
% object.vertices(:,1) = object.vertices(:,1) + 5;
% lattice(1:end/3) = lattice(1:end/3) + 5;
% objectN.faces = object.faces;
% segmentX = object.vertices(:,1);
% segmentY = object.vertices(:,2);
% segmentZ = object.vertices(:,3);
% objectN.vertices = [segmentX.*log(segmentX),segmentY,segmentZ];

N1 = size(X,2)/3;
maxX = max(object.vertices(:,1));
minX = min(object.vertices(:,1));
maxY = max(object.vertices(:,2));
minY = min(object.vertices(:,2));
x = [X(1:N1),X(N1+1:2*N1),X(2*N1+1:end) + X(2*N1+1:end).*((((0.5-0.00001*(X(1:N1)-275).^2)>0).*(0.5-0.00001*(X(1:N1)-275).^2)*2)+(((0.5-0.00001*(X(1:N1)-650).^2)>0).*(0.5-0.00001*(X(1:N1)-650).^2))).*(( X(1:N1)-minX)/(maxX-minX) )];
objectN.faces = object.faces;
segmentX = object.vertices(:,1);
segmentY = object.vertices(:,2);
segmentZ = object.vertices(:,3);
% objectN.vertices = [segmentX + segmentX.*((((0.5-0.001*(segmentY-25).^2)>0).*(0.5-0.001*(segmentY-25).^2))+(((0.5-0.001*(segmentY-62).^2)>0).*(0.5-0.001*(segmentY-62).^2))).*(( segmentX-minX)/(maxX-minX) ),segmentY,segmentZ];
%for the larger one in z:
objectN.vertices = [segmentX ,segmentY,segmentZ + segmentZ.*((((0.5-0.00001*(segmentX-275).^2)>0).*(0.5-0.00001*(segmentX-275).^2)*2)+(((0.5-0.00001*(segmentX-650).^2)>0).*(0.5-0.00001*(segmentX-650).^2))).*((segmentX-minX)/(maxX-minX) )];

clear N1