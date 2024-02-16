function [D2,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta)
%B2SOLVE3D Summary of this function goes here
%   Detailed explanation goes here
M2 = size(f1,2);
M3 = size(f2,2);
D2Aug = zeros(3*M2,3*M2);
B2 = zeros(3*M2,3*M3);
for i = 1:size(f1,2)
    [~,localIndex] = neighbours3D(f1(i),lattice,cols,rows);
    temp = localIndex(find(ismember(localIndex,f1)));
    if size(temp,2) < 4
        tempNeg = localIndex(find(ismember(localIndex,theta)));
        for j = 1:size(tempNeg,2)
            [~,localIndex] = neighbours3D(tempNeg(j),lattice,cols,rows);
            temp = [temp,localIndex(find(ismember(localIndex,f1)))];
        end
    end
    temp = unique(temp);
    temp(find(temp==f1(i))) = [];
    localIndex = temp;
    val = 1/(sum(ismember(localIndex,f1)));

    for j = 1:size(localIndex,2)
        if ismember(localIndex(j),f2)
            B2(i,find(f2==localIndex(j))) = val;
            continue;
        end
        if ismember(localIndex(j),f1)
            D2Aug(i,find(f1==localIndex(j))) = -val;
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
B2(M2+1:2*M2,M3+1:2*M3) = B2(1:M2,1:M3);
B2(2*M2+1:3*M2,2*M3+1:3*M3) = B2(1:M2,1:M3);

D2 = zeros(3*M2,3*M2);
D2(1:M2,1:M2) = D2Aug(1:M2,1:M2);
D2(M2+1:2*M2,M2+1:2*M2) = D2(1:M2,1:M2);
D2(2*M2+1:3*M2,2*M2+1:3*M2) = D2(1:M2,1:M2);
end

