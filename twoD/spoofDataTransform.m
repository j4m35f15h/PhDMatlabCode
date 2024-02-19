%The role of this script is to apply a transform to our initial
%coordinates. The applied growth field needs to have two components, a
%magnitude and anisotropy. These will compine to push the markers to mimic
%growth. We need to decide how to describe these. Both can use the
%coordinate in some kind of formula.

%We can have it so that the further to the righ of the rudiment, the higher
%the growth rate, and the further away from the midline you get, the more
%vertical the growth.

growthMag = 1.05*X(1:end/2);
anisotropy = pi*(X(1+end/2:end) - 0.5);
x = [X(1:end/2) + X(1:end/2).*growthMag.*cos(anisotropy) ,X(1+end/2:end) + X(1+end/2:end).*sqrt(growthMag).*sin(anisotropy)];
% growthMag = 1.005*X(1:end/2);
% anisotropy = 0;
% x = [X(1:end/2) + X(1:end/2).*growthMag.*cos(anisotropy) ,X(1+end/2:end)];

growthMag = 1.05*segmentX;
anisotropy = pi*(segmentY - 0.5);
segmentXN = segmentX + segmentX.*growthMag.*cos(anisotropy);
segmentYN = segmentY + segmentY.*sqrt(growthMag).*sin(anisotropy);
% growthMag = 1.005*segmentX;
% anisotropy = 0;
% segmentXN = segmentX + segmentX.*growthMag.*cos(anisotropy);
% segmentYN = segmentY;