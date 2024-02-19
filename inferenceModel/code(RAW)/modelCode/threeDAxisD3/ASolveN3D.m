function [A] = ASolveN3D(X,theta,lattice,faces,faceID)
%ASOLVE Summary of this function goes here
%   Detailed explanation goes here
N = size(X,2)/3;
M1 = size(theta,2);

w = zeros(N,8);
% w = sym('W',[N 4]);
for i = 1:N
    
    local = [lattice(1,faces(faceID(i,1),:)),lattice(1,faces(faceID(i),:) + size(lattice,2)/3),lattice(1,faces(faceID(i),:) + 2*size(lattice,2)/3)];
    w(i,:) = interpolationCoef3D(local,[X(i) X(i + N) X(i + 2*N)]);
end

%We can obtain the interpolation coefficients for each one, but we will
%need to reform the A matrix. Currently we have a series of row vectors
%corresponding to the interpolation coefficients in the order that their
%found in faces. We need to set the value in each index to be the value of
%the index corresponding to the index written in faces.

A = zeros(3*N,3*M1);
for i = 1 : N
    lIndex = faces(faceID(i),:);
    for j = 1:8
        A(i,find(theta==lIndex(j))) = deal(w(i,j));
    end
end
A(N+1:2*N,M1+1:2*M1) = A(1:N,1:M1);
A(2*N+1:3*N,2*M1+1:3*M1) = A(1:N,1:M1);
end

