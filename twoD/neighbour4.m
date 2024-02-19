function [out] = neighbour4(In,lattice,faces)
%NEIGHBOUR4 Summary of this function goes here
%   We need to use the input index to find the connected lattice points.
%   The connection information will be in faces. Select lattice points that
%   um of elements equal is 2. Once four are found find the coordinates in
%   lattice and return their indexes.
    out = zeros(1,4);
    
    %Need to look through faces and return the indexes of points that
    %include In
    listFaces = zeros(4,4);
    k = 1;
    for i = 1:size(faces,1)
        for j = 1:4
            if(faces(i,j) == In)
                listfaces(k,:) = faces(i,:);
                k = k+1;
            end
        end
    end

    %listFaces now contains the indexes of the faces that include the
    %center point
    list = unique(listfaces);
    
    if size(list,1) == 9
        k = 1;
        for i = 1:size(list,1)
            if sum(sum(listfaces == list(i))) == 2
                out(k) = list(i);
                k = k+1;
            end
        end
    %We need a special case for points that are on the edge of the
    %calculation domain. if the number of faces that include the index
    %point is equal to 2, then the sum total would be different
    elseif size(list,1) == 6
    elseif size(list,1) == 4
    end
    
    
    
end

