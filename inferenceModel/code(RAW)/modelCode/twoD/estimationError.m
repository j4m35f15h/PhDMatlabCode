function [error] = estimationError(lattice,latticeNew,theta)
%ESTIMATIONERROR Summary of this function goes here
%   The estimation error represents the error power of the lattice
%   positions, normalised by the number of positions. This applies only to
%   the theta points (calculation domain)
summation = 0;
for i = 1: size(theta,2)
    summation = summation + norm([lattice(theta(i));lattice(theta(i) + size(lattice,2)/2)]...
                                  -[latticeNew(theta(i));latticeNew(theta(i) + size(lattice,2)/2)]);
end
error = sqrt(summation/size(theta,2));
end

