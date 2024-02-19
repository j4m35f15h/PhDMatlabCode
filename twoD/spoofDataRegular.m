%for all of theta, if theta is in polygon, generate5 data points with theta
%as mean , ignoring data point outside of in polygon.
var = 0.009;
temp = [];
for i = 1:1:size(theta,2)
    if inpolygon(lattice(theta(i)),lattice(theta(i)+size(lattice,2)/2),segmentX,segmentY)
        for j = 1:4
            tX = normrnd(lattice(theta(i)),var);
            tY = normrnd(lattice(theta(i)+size(lattice,2)/2),var);
            while ~inpolygon(tX,tY,segmentX,segmentY)
                tX = normrnd(lattice(theta(i)),var);
                tY = normrnd(lattice(theta(i)+size(lattice,2)/2),var);
            end
            temp = [temp,tX,tY];
        end
    end
end
X = [temp(1,1:2:end),temp(1,2:2:end)];
clear temp var tX tY;
