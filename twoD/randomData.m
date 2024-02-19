function [X] = randomData(lattice,cols,theta,N)
%RANDOMDATA Produces test input data that's uniformly distributed.
%   Generate random point coordinates within the calculation domain.
%   Another function will then transform the data following some
%   theoretical growth map.
[bounds1,bounds2,~] = setboundary(lattice,cols);
bounds = [bounds1,bounds2];
X = zeros(size(1,2*N));
%Keep generating numbers between zero and 1, and check if the point is
%within the boundary of theta. We'll assume that the 

end

