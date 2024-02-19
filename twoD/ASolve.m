function [A] = ASolve(X,theta,faces,faceID)
%ASOLVE Summary of this function goes here
%   Detailed explanation goes here
N = size(X,2)/2;
M1 = size(theta,2)/2;

w = zeros(N,4);
for i = 1:N
    local = [theta(1,faces(faceID(i,1),:)),theta(1,faces(faceID(i),:) + M1)];
    w(i,:) = interpolationCoef(local,[X(i) X(i + N)]);
end

%We can obtain the interpolation coefficients for each one, but we will
%need to reform the A matrix. Currently we have a series of row vectors
%corresponding to the interpolation coefficients in the order that their
%found in faces. We need to set the value in each index to be the value of
%the index corresponding to the index written in faces.
A = zeros(2*N,2*M1);
for i = 1 : N
    lIndex = faces(faceID(i),:);
    A(i,lIndex) = deal(w(i,:));
end
A(N+1:end,M1+1:end) = A(1:N,1:M1);

end

