function [local,localIndex] = neighbours3D(In,lattice,cols,rows)
%NEIGHBOURS3D Finds the directly connected neighbours of a given vertex (by 
%index In). For each of the six possible neighbours, we check if the index
%given is at the end. Out of bounds neighbours are NaN by default.

M1 = size(lattice,2)/3;
X = NaN(1,6);
Y = NaN(1,6);
Z = NaN(1,6);
localIndex = NaN(1,6);
In2 = In + M1;
In3 = In2 + M1;
if(In+cols <= M1) &&  (ceil((In+cols)/(rows*cols)) ==  ceil(In/(rows*cols))) %Not out of bound and same plane  
    X(1) = lattice(In+(cols));
    Y(1) = lattice(In2+(cols));
    Z(1) = lattice(In3 + cols);
    localIndex(1) = In+cols;
end
if(In+1 <= M1 && mod(In+1,cols)~=1 && (ceil((In+1)/(rows*cols)) ==  ceil(In/(rows*cols)))) %not out of bound, same line, same plane
    X(2) = lattice(In+1);
    Y(2) = lattice(In2+1);
    Z(2) = lattice(In3 + 1);
    localIndex(2) = In+1;
end
if(In-cols > 0 &&  (ceil((In-cols)/(rows*cols)) ==  ceil(In/(rows*cols))))
    X(3) = lattice(In-(cols));
    Y(3) = lattice(In2-(cols));
    Z(3) = lattice(In3-(cols));
    localIndex(3) = In-cols;
end
if(In-1 > 0 && mod(In-1,cols)~=0 && (ceil((In-1)/(rows*cols)) ==  ceil(In/(rows*cols))))
%     X(4)
%     lattice(In-1)
    X(4) = lattice(In-1);
%     X(4)
    Y(4) = lattice(In2-1);
    Z(4) = lattice(In3-1);
    localIndex(4) = In-1;
end

if(In+(rows*cols) <= M1)
    X(5) = lattice(In+(cols*rows));
    Y(5) = lattice(In2+(cols*rows));
    Z(5) = lattice(In3+(cols*rows));
    localIndex(5) = In+(rows*cols);
end
if(In-(cols*rows) > 0)
    X(6) = lattice(In-(cols*rows));
    Y(6) = lattice(In2-(cols*rows));
    Z(6) = lattice(In3-(cols*rows));
    localIndex(6) = In-(cols*rows);
end

% X = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)]; %indexes of local In clockwise fashion
% In = In + M1;
% Y = [lattice(In+(cols)),lattice(In+1),lattice(In-(cols)),lattice(In-1)];
local = [X,Y,Z];
end

