function [faceID] = faceIDFind3D(X,lattice,faces,object)
%FACEIDFIND Summary of this function goes here
%   Detailed explanation goes here
N = size(X,2)/3;
L = size(lattice,2)/3;

faceID = zeros(N,1);
for j = 1:size(faces,1)
    for i = 1:N
%         if all(abs([lattice(faces(j,:),1)-X(i,1),lattice(faces(j,:),2)-X(i,2),lattice(faces(j,:),3)-X(i,3)])<=a)
        if all([abs(lattice(1,faces(j,:))-X(1,i))<=object.resolution(1)...
                ,abs(lattice(1,faces(j,:)+L)-X(1,i+N))<=object.resolution(2)...
                ,abs(lattice(1,faces(j,:)+2*L)-X(1,i+2*N))<=object.resolution(3)])
            faceID(i,1) = j;
        end
    end
end

%FaceId now has the index of the face that the point is located within. We
%know need to extract the coordinates and send them to interpolation
%coefficient.
end

