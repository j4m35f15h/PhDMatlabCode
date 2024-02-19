%for all of theta, if theta is in polygon, generate5 data points with theta
%as mean , ignoring data point outside of in polygon.
var = 10;
temp = [];
for i = 1:1:size(theta,2)
    if inpolyhedron(object,lattice(theta(i)),lattice(theta(i)+size(lattice,2)/3),lattice(theta(i)+2*size(lattice,2)/3)) && (lattice(theta(i))>50)
        for j = 1:3
            tX = normrnd(lattice(theta(i)),var);
            tY = normrnd(lattice(theta(i)+size(lattice,2)/3),var);
            tZ = normrnd(lattice(theta(i)+2*size(lattice,2)/3),var);
            while ~inpolyhedron(object,tX,tY,tZ)
                tX = normrnd(lattice(theta(i)),var);
                tY = normrnd(lattice(theta(i)+size(lattice,2)/3),var);
                tZ = normrnd(lattice(theta(i)+2*size(lattice,2)/3),var);
            end
            temp = [temp,tX,tY,tZ];
        end
    end
end
X = [temp(1,1:3:end),temp(1,2:3:end),temp(1,3:3:end)];
clear temp var tX tY;
