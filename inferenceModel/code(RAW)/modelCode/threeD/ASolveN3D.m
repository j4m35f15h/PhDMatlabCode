function [A] = ASolveN3D(X,theta,lattice,faces,faceID)
%ASOLVE calculates interpolation coefficients and sort them into the A
%matrix (combines the solve and process functions for the B1 coef)
N = size(X,2)/3;
M1 = size(theta,2);

w = zeros(N,8);
for i = 1:N %For each cell coordinate
    local = [lattice(1,faces(faceID(i,1),:)),lattice(1,faces(faceID(i),:) + size(lattice,2)/3),lattice(1,faces(faceID(i),:) + 2*size(lattice,2)/3)];
    w(i,:) = interpolationCoef3D(local,[X(i) X(i + N) X(i + 2*N)]); %Define interpolation coefficients given the surrounding cube
end

%Need to distribute the interpolation coefficients for the later martix
%multiplication
A = zeros(3*N,3*M1);
for i = 1 : N %For each cell coorinate
    localIndex = faces(faceID(i),:); %Return indices of the cube
    for j = 1:8
        A(i,find(theta==localIndex(j))) = deal(w(i,j)); %Distribut the coefficients
    end
end
%Copy the matrix for the other dimensions.
A(N+1:2*N,M1+1:2*M1) = A(1:N,1:M1);
A(2*N+1:3*N,2*M1+1:3*M1) = A(1:N,1:M1);
end

