function [outputArg1] = RZ(degs)
%RZ returns the rotation matrix for a specific degree val and axis
degs = deg2rad(degs);
outputArg1 = [cos(degs) -sin(degs) 0; sin(degs) cos(degs) 0; 0 0 1];

end

