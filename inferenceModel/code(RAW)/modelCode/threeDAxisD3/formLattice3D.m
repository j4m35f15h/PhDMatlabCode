function [lattice,faces,object] = formLattice3D(rows,cols,deps,object)
%FORMLATTICE Summary of this function goes here
%   Needs to produce the lattice vector
[xcoord,ycoord,zcoord] = deal(zeros(size(1,rows*cols*deps)));
%ycoord = zeros(size(1,rows*cols*deps));
%zcoord = zeros(size(1,rows*cols*deps));
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

%Here we can insert the code to rescale the lattice resolution to satify
%the conditions we've specified, then add an offset to the object so that
%it sits within the right position in the lattice

deltaX = max(object.vertices(:,1)) - min(object.vertices(:,1));
deltaY = max(object.vertices(:,2)) - min(object.vertices(:,2));
deltaZ = max(object.vertices(:,3)) - min(object.vertices(:,3));
xcoord = xcoord*cols*deltaX/(cols-3);
ycoord = ycoord*rows*deltaY/(rows-3);
zcoord = zcoord*deps*deltaZ/(deps-3);
lattice = [xcoord/j,ycoord/i,zcoord/k];
adjustX = 1.5*deltaX/(cols-3) - min(object.vertices(:,1));
adjustY = 1.5*deltaY/(rows-3) - min(object.vertices(:,2));
adjustZ = 1.5*deltaZ/(deps-3) - min(object.vertices(:,3));
object.resolution = [lattice(2),lattice(1+size(lattice,2)/3+cols),lattice(1+2*size(lattice,2)/3+rows*cols)];
object.vertices = [object.vertices(:,1)+adjustX,object.vertices(:,2)+adjustY,object.vertices(:,3)+adjustZ];
object.offset = [adjustX,adjustY,adjustZ];

N = size(lattice,2)/3;
faces = formFaces3D(rows,cols,deps);
faces( ~any(faces,2), : ) = [];
% Faces outside of the calculation domain need to be ignored
for i = 1:size(faces,1) %If any faces include no members located inside of the polyhedron, deal 0
%    for j = 1:4 
%        if faces(i,j) < cols+1 || faces(i,j) >cols*(rows-1) || mod(faces(i,j),cols) == 0 || mod(faces(i,j),cols) == 1
%            faces(i,:) = deal(0);
%            break;
%        end
%    end
     if all(~inpolyhedron(object,[lattice(faces(i,:)')',lattice(faces(i,:)'+N)',lattice(faces(i,:)' + 2*N)']))
        faces(i,:) = deal(0);
     end
end
faces = faces(any(faces,2),:);
end

