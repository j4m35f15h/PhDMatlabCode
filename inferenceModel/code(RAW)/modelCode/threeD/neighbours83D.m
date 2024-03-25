function [local,localIndex] = neighbours83D(In,lattice,cols,rows)
%NEIGHBOURS83D Finds the 26 vertices that surround a vertex. These are
%found by finding the neighbours of the neighbours from using the simpler
%neighbours3D function

%This function will return a zero if provided with an edge position.

[~,localIndex] = neighbours3D(In,lattice,cols,rows);
[~,tempLocalIndex] = neighbours3D(localIndex(1),lattice,cols,rows);
localIndex = [localIndex,tempLocalIndex(2),tempLocalIndex(4),tempLocalIndex(5),tempLocalIndex(6)];

[~,temptempLocalIndex] = neighbours3D(tempLocalIndex(4),lattice,cols,rows);
localIndex = [localIndex,temptempLocalIndex(5),temptempLocalIndex(6)];
[~,temptempLocalIndex] = neighbours3D(tempLocalIndex(2),lattice,cols,rows);
localIndex = [localIndex,temptempLocalIndex(5),temptempLocalIndex(6)];

[~,tempLocalIndex] = neighbours3D(localIndex(3),lattice,cols,rows);
localIndex = [localIndex,tempLocalIndex(2),tempLocalIndex(4),tempLocalIndex(5),tempLocalIndex(6)];

[~,temptempLocalIndex] = neighbours3D(tempLocalIndex(4),lattice,cols,rows);
localIndex = [localIndex,temptempLocalIndex(5),temptempLocalIndex(6)];
[~,temptempLocalIndex] = neighbours3D(tempLocalIndex(2),lattice,cols,rows);
localIndex = [localIndex,temptempLocalIndex(5),temptempLocalIndex(6)];

[~,tempLocalIndex] = neighbours3D(localIndex(4),lattice,cols,rows);
localIndex = [localIndex,tempLocalIndex(5),tempLocalIndex(6)];

[~,tempLocalIndex] = neighbours3D(localIndex(2),lattice,cols,rows);
localIndex = [localIndex,tempLocalIndex(5),tempLocalIndex(6)];

if any(isnan(localIndex))
    local = 0;
    localIndex = 0;
    return;
end
N = size(lattice,2)/3;
local = [lattice(localIndex),lattice(localIndex+N),lattice(localIndex+2*N)];


end

