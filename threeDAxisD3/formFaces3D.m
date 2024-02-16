function [faces] = formFaces3D(rows,cols,deps)
%FORMFACES Summary of this function goes here
%   Detailed explanation goes here

faces = zeros(size( (rows-1)*(cols-1)*(deps-1) ,4));
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

