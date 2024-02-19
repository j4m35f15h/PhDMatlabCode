function [faces] = formFaces(rows,cols)
%Creates a list of all possible faces in a lattice of given dimensions.
%This will be refined later.

faces = zeros(size( (rows-1)*(cols-1) ,4));
pos = 1;
for i = 1:rows-1
    for j = 1:cols-1
        faces(j+(cols*(i-1)),1) = pos;
        faces(j+(cols*(i-1)),2) = pos+cols;
        faces(j+(cols*(i-1)),3) = pos+cols+1;
        faces(j+(cols*(i-1)),4) = pos+1;
        pos = pos+1;
    end
    pos = pos+1;
end
end

