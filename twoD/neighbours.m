function [local,localIndex] = neighbours(In,lattice,cols)
%NEIGHBOURS Summary of this function goes here
%   Needs to return the coordinates of the neighbours in the correct
%   formatting. Stack X coordinates onto array, stack Y onto array, then
%   stack onto eachother.
M1 = size(lattice,2)/2;
X = NaN(1,4);
Y = NaN(1,4);
localIndex = NaN(1,8);
In2 = In + M1;
if(In+cols <= M1)
    X(1) = lattice(In+(cols));
    Y(1) = lattice(In2+(cols));
    localIndex(1) = In+cols;
    localIndex(5) = In+cols;
end
if(In+1 <= M1 && mod(In+1,cols)~=1)
    X(2) = lattice(In+1);
    Y(2) = lattice(In2+1);
    localIndex(2) = In+1;
    localIndex(6) = In+1;
end
if(In-cols > 0)
    X(3) = lattice(In-(cols));
    Y(3) = lattice(In2-(cols));
    localIndex(3) = In-cols;
    localIndex(7) = In-cols;
end
if(In-1 > 0 && mod(In-1,cols)~=0)
    X(4) = lattice(In-1);
    Y(4) = lattice(In2-1);
    localIndex(4) = In-1;
    localIndex(8) = In-1;
end

% X = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)]; %indexes of local In clockwise fashion
% In = In + M1;
% Y = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)];
local = [X,Y];
end

