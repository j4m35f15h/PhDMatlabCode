function [outputArg1] = RY(degs)
%RY Summary of this function goes here
%   Detailed explanation goes here
degs = deg2rad(degs);
outputArg1 = [cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)];

end

