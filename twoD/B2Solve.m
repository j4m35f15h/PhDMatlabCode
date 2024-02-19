function [D2,B2] = B2Solve(f1,f2,lattice,cols)
%B2SOLVE Summary of this function goes here
%   Since the equations are similar, and no actual solving is required,
%   we'll outout the desired D2 and B2 by the end of this. We are
%   effectively combining the B1Solve() and B1Process() functions.

%We need to look into the lattice, find out which indexes are boundary
%points that are also connected. Each one should have 2 neighbours
M2 = size(f1,2);
D2Aug = zeros(2*M2,2*M2);
B2 = zeros(2*M2,4);
for i = 1:size(f1,2)
    [~,localIndex] = neighbours8(f1(i),lattice,cols);
    for j = 1:size(localIndex,2)
        if ismember(localIndex(j),f2)
            B2(i,find(f2==localIndex(j))) = 0.5;
            continue;
        end
        if ismember(localIndex(j),f1)
            D2Aug(i,find(f1==localIndex(j))) = -0.5;
        end
    end
    D2Aug(i,i) = 1;
end

%At This point, we have a matrix that uss all of the boundary points. We
%now need to diminish the matix into just the bounday points, and the edges
%of the boundary. I can assume that we use the first and last point.
% for i = 2:M2-1
%     B2(i-1,1) = D2Aug(i,1);
%     B2(i-1,2) = D2Aug(i,M2);
% end
B2(M2+1:end,3:4) = B2(1:M2,1:2);

D2 = zeros(2*M2,2*M2);
D2(1:M2,1:M2) = D2Aug(1:M2,1:M2);
D2(M2+1:end,M2+1:end) = D2(1:M2,1:M2);
end

