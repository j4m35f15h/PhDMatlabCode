function [outputArg1] = RX(degs)
%RX Summary of this function goes here
%   Detailed explanation goes here
degs = deg2rad(degs);
outputArg1 = [1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)];
end

