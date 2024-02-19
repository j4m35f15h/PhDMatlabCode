function [local,localIndex] = neighbours8(In,lattice,cols)
%NEIGHBOURS8 returns the coordinates of full surrounding
%   run neighbours on a point, then run neighbours on the returned
%   coordinates. Steack them together and

%This function will error is provided with an edge position.

[local,localIndex] = neighbours(In,lattice,cols);
[tempLocal,tempLocalIndex] = neighbours(localIndex(1),lattice,cols);
local = [local,tempLocal(2),tempLocal(4)];
localIndex = [localIndex,tempLocalIndex(2),tempLocalIndex(4)];
[tempLocal,tempLocalIndex] = neighbours(localIndex(3),lattice,cols);
local = [local,tempLocal(2),tempLocal(4)];
localIndex = [localIndex,tempLocalIndex(2),tempLocalIndex(4)];
% local = unique(local);
% localIndex = unique(localIndex);

% X = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)]; %indexes of local In clockwise fashion
% In = In + M1;
% Y = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)];

%the output of neighbours is alwasy in a clockwise order, so all I have to
%do is walk around the circle and record the indexes.

end

