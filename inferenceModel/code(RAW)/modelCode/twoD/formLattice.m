function [latticeV,latticeF] = formLattice(rows,cols)
%Generates an indexed square mesh consisting of vertices and faces
%given input dimensions

%Initialise arrays for the coordinates of each intersection
xcoord = zeros(size(1,rows*cols));
ycoord = zeros(size(1,rows*cols));

%Each vertex provided column and row values
pos = 1;
for i = 0:rows-1
    for j = 0:cols-1
        xcoord(pos) = j;
        ycoord(pos) = i;
        pos = pos + 1;
    end
end
%Column and row values replaced with relative value (to scale with geometry later)
latticeV = [xcoord/j,ycoord/i];

%Assigns four vertices to each square in the mesh
latticeF = formFaces(rows,cols);
latticeF( ~any(latticeF,2), : ) = []; %Tidy array

%Faces outside of the calculation domain need to be ignored
for i = 1:size(latticeF,1)
    for j = 1:4
        if latticeF(i,j) < cols+1 || latticeF(i,j) >cols*(rows-1) || mod(latticeF(i,j),cols) == 0 || mod(latticeF(i,j),cols) == 1
            latticeF(i,:) = deal(0);
            break;
        end
    end
end
latticeF = latticeF(any(latticeF,2),:); %Delete zero rows
end

