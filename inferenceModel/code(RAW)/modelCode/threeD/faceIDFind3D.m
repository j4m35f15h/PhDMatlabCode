function [faceID] = faceIDFind3D(X,lattice,faces,object)
%FACEIDFIND identifies which cube each of the coordinates stored in X are in. 
N = size(X,2)/3;
L = size(lattice,2)/3;

faceID = zeros(N,1);
for j = 1:size(faces,1) %For each cube
    for i = 1:N         %For each label coordinate
        %If the absolute value of the difference between the coordinate of
        %the label, and the bottom left coordinate of a face, is less than
        %the resolution of the lattice...
        if all([abs(lattice(1,faces(j,:))-X(1,i))<=object.resolution(1)... 
                ,abs(lattice(1,faces(j,:)+L)-X(1,i+N))<=object.resolution(2)...
                ,abs(lattice(1,faces(j,:)+2*L)-X(1,i+2*N))<=object.resolution(3)])
            faceID(i,1) = j;
        end
    end
end
end

