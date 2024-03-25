function [lattice,faces,object] = formLattice3D(rows,cols,deps,object)
%FORMLATTICE produces a 1x3N vector containing the x y and z coordinates
%describing an evenly spaced grid/lattice with the dimensions provided.
%(Where N=rows*cold*deps i.e. the total number of lattice intesections)

[xcoord,ycoord,zcoord] = deal(zeros(size(1,rows*cols*deps)));

%Generate the coordinates in a 3D grid.
%assigns a label (i.e. a natrual number), which will be replaced
pos = 1;
for k = 0:deps-1
    for i = 0:rows-1
        for j = 0:cols-1
            xcoord(pos) = j;
            ycoord(pos) = i;
            zcoord(pos) = k;
            pos = pos + 1;
        end
    end
end

%Here we rescale the lattice resolution to satify the conditions we've 
%specified (i.e. # of rows etc), then add an offset to the object so that
%it sits within the right position in the lattice

%Calculates distance lattice needs to cover
deltaX = max(object.vertices(:,1)) - min(object.vertices(:,1));
deltaY = max(object.vertices(:,2)) - min(object.vertices(:,2));
deltaZ = max(object.vertices(:,3)) - min(object.vertices(:,3));

%Rescales id to coordinates, while adding a 1.5*gridSize buffer on edges
xcoord = xcoord*cols*deltaX/(cols-3);
ycoord = ycoord*rows*deltaY/(rows-3);
zcoord = zcoord*deps*deltaZ/(deps-3);

%Concatenate and normalise the coordinates
lattice = [xcoord/j,ycoord/i,zcoord/k];

%Calculate and apply the adjustment to match the buffer
adjustX = 1.5*deltaX/(cols-3) - min(object.vertices(:,1));
adjustY = 1.5*deltaY/(rows-3) - min(object.vertices(:,2));
adjustZ = 1.5*deltaZ/(deps-3) - min(object.vertices(:,3));
object.vertices = [object.vertices(:,1)+adjustX,object.vertices(:,2)+adjustY,object.vertices(:,3)+adjustZ];

%Store the offset and lattice resolutions for later use
object.resolution = [lattice(2),lattice(1+size(lattice,2)/3+cols),lattice(1+2*size(lattice,2)/3+rows*cols)];
object.offset = [adjustX,adjustY,adjustZ];

%Next we need to generate the sets of vertices that describe each cube
N = size(lattice,2)/3;
faces = formFaces3D(rows,cols,deps);
faces( ~any(faces,2), : ) = []; %Remove an cubes that failed to form

%Cubes that do not contain the geometry need to be ignored
for i = 1:size(faces,1) 
    %If any cubes include no vertices located inside of the geometry, deal 0
     if all(~inpolyhedron(object,[lattice(faces(i,:)')',lattice(faces(i,:)'+N)',lattice(faces(i,:)' + 2*N)']))
        faces(i,:) = deal(0);
     end
end
%Delete those faces found
faces = faces(any(faces,2),:);
end

