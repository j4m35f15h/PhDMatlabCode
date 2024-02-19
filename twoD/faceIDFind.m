function [faceID] = faceIDFind(X,latticeV,latticeF)
%Returns the index of the faces a set of coordinates, X, are located within
N = size(X,2)/2;
M1 = size(latticeV,2)/2;

faceID = zeros(N,1);
%Checks if the ith label coordinate is contained within the jth face.
for j = 1:size(latticeF,1)
    for i = 1:N
        if inpolygon(X(i),X(i+N),latticeV(1,latticeF(j,:)),latticeV(1,latticeF(j,:) + M1)) 
            faceID(i,1) = j;
            continue;
        end
    end
end

end

