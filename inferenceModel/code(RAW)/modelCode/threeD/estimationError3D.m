function [error] = estimationError3D(latticeNew,trueLattice,theta)
%ESTIMATIONERROR3D Summary of this function goes here
%   Detailed explanation goes here
M1 = size(theta,2)/3;
N = size(latticeNew,2)/3;
summation = 0;
for i = 1:M1
    summation = summation + norm([latticeNew(theta(i))-trueLattice(theta(i));...
        latticeNew(theta(i)+N)-trueLattice(theta(i)+N);...
        latticeNew(theta(i)+2*N)-trueLattice(theta(i)+2*N)]);
end
error = summation/(M1);
end

