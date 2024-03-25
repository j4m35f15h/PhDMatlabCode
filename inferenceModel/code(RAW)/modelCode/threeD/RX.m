function [outputArg1] = RX(degs)
%RX returns the rotation matrix for a specific degree val and axis
degs = deg2rad(degs);
outputArg1 = [1 0 0; 0 cos(degs) -sin(degs); 0 sin(degs) cos(degs)];

end

