for i = 1:size(f4,2)
%At this current point, we have a function CE which allows us to obtain a
%number for the convolutional error. From here, the next step is to use
%this o probe the initial disttributions to perform the divergence
%minimisation. There is an easy way and a hard way to do this:

%Easy way:
% take the initial lattice f4 points.
% move them in the x y and z direction
% calculate the error obtained for the smoothness of internal deformation
% and for the CE
% calculate and store for all f4 members
%find a svcaling factor which minimises the difference: 
%min( SID + mu4*sum(CE) )
%return mu4

% Hard way:
% take the initial lattice f4 points.
% move them in the x y and z direction
% calculate the error obtained for the smoothness of internal deformation
% and for the CE
% For each f4 point, attempt to fit a gaussian curve to the x y and z error
% values.
% Find a variance parameter that minimises the divergence in shannon
% entropy os the

end