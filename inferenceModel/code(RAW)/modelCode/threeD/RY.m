function [outputArg1] = RY(degs)
%RY returns the rotation matrix for a specific degree val and axis
degs = deg2rad(degs);
outputArg1 = [cos(degs) 0 sin(degs); 0 1 0; -sin(degs) 0 cos(degs)];

end

