function [faces] = formFaces3D(rows,cols,deps)
%FORMFACES For each cube in the lattice, creates an 8 element vectore
%containing the indices of the vertices that outline the cube. Works
%similarly to how meshes are created from STL files.

%The number of cubes is one fewer than the number of vertices in each
%dimension.
faces = zeros(size( (rows-1)*(cols-1)*(deps-1) ,8));

%Consider the loop as moving to invidual vertices, and defining a single
%cube it is a part of. by performing this for all vertices not on the outer
%edge, all cubes are created. 
pos = 1;
for k = 1:deps-1
    for i = 1:rows-1
        for j = 1:cols-1
            
            faces(pos,1) = pos;
            faces(pos,2) = pos+cols;
            faces(pos,3) = pos+cols+1;
            faces(pos,4) = pos+1;
            
            faces(pos,5) = pos+rows*cols;
            faces(pos,6) = pos+cols+rows*cols;
            faces(pos,7) = pos+cols+1+rows*cols;
            faces(pos,8) = pos+1+rows*cols;
            
            pos = pos+1;
        end
        pos = pos+1;
    end
    pos = pos+cols;
end
end

