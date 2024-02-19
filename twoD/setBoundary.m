function [f1,f2,theta] = setBoundary(lattice,cols)
%FINDBOUNDARY Summary of this function goes here
%   Detailed explanation goes here
M1 = size(lattice,2)/2;
f1 = [];
for i = 1:M1
    [local,~] = neighbours(i,lattice,cols);
    if sum(isnan(local))
        f1 = [f1,i];
    end
end
theta = 1:M1;
theta = theta(~ismember(theta,f1));
f2 = [f1(1) f1(2)];
f1(1) = [];
f1(1) = [];
end

