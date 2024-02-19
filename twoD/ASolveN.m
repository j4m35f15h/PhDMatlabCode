function [A] = ASolveN(X,theta,lattice,faces,faceID)

N = size(X,2)/2; %N is the number of labels
M1 = size(theta,2); %M1 is the number of lattice coordinates in the calc. domain

w = zeros(N,4);
for i = 1:N %For each label coordinate...
    %... Find the coordinates of the vertices of the face...
    local = [lattice(1,faces(faceID(i,1),:)),lattice(1,faces(faceID(i),:) + size(lattice,2)/2)];
    %Use those coordinates as well as the x  and y value of the label  to
    %calculate the interpolation coefficients.
    w(i,:) = interpolationCoef(local,[X(i) X(i + N)]);
end

%In the final A matrix, each column reflecs an index in the lattice
%coordinates, and each row the index of a labelled coordinate. For each
%labelled coordinate, the interpolation coefficients calculated previously 
%need to therefore be placed into the appropriate columns.
A = zeros(2*N,2*M1);

for i = 1 : N%For each labelled coordinate...
    lIndex = faces(faceID(i),:);%...find the appropriate face number
    for j = 1:4%For each of the four face vertices...
        A(i,find(theta==lIndex(j))) = deal(w(i,j));%...distribute the interpolation coefficients
    end
end
%Duplicate the A matrix after the bottom right diagonal for y-value
%interpolation
A(N+1:end,M1+1:end) = A(1:N,1:M1);

end

