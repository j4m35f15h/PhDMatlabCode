function [outputArg1] = RZ(degs)
%RZ Summary of this function goes here
degs = deg2rad(degs);
outputArg1 = [cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1];

end

