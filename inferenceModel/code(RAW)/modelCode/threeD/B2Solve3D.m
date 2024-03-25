function [D2Aug,B2] = B2Solve3D(f1,f2,lattice,cols,rows,theta)
%B2SOLVE3D Summary of this function goes here
%   Detailed explanation goes here
M2 = size(f1,2);
M3 = size(f2,2);
D2Aug = zeros(3*M2,3*M2);
B2 = zeros(3*M2,3*M3);

for i = 1:size(f1,2) %For every lattice coordinate in the boundary domain
    [~,localIndex] = neighbours3D(f1(i),lattice,cols,rows); %find its neighbours
    temp = localIndex(find(ismember(localIndex,f1))); %find neighbours in the boundary domain
    
    %Due to cornering, come may only have 3 or 2 neighbours. In this case
    %we consider the neighbours of neighbours:
    if size(temp,2) < 4 %If the neighbour count is less than 4
        tempNeg = localIndex(find(ismember(localIndex,theta))); %Fine the calculation domin neighbours
        for j = 1:size(tempNeg,2)
            [~,localIndex] = neighbours3D(tempNeg(j),lattice,cols,rows); %Find the neighbours of the cal domain neighbours
            temp = [temp,localIndex(find(ismember(localIndex,f1)))]; %Consider any neighbour neighbours as neighbours if in the boundary domain
        end
    end
    
    temp = unique(temp); %remove duplicates
    temp(find(temp==f1(i))) = []; %remove the self
    localIndex = temp;
    val = 1/(sum(ismember(localIndex,f1))); % average coefficient depends on the number of f1 neighours ofund

    for j = 1:size(localIndex,2)
        if ismember(localIndex(j),f2) %If the neighbour is in f2...
            B2(i,find(f2==localIndex(j))) = val; %...store the value in B2
            continue;
        end
        if ismember(localIndex(j),f1) %if the neighbour is in f1
            D2Aug(i,find(f1==localIndex(j))) = -val; %...store the value in D2
        end
    end
    D2Aug(i,i) = 1; % Set diagonals to 1
end

%Copy the matrix for the other dimensions.
B2(M2+1:2*M2,M3+1:2*M3) = B2(1:M2,1:M3);
B2(2*M2+1:3*M2,2*M3+1:3*M3) = B2(1:M2,1:M3);

D2Aug(M2+1:2*M2,M2+1:2*M2) = D2Aug(1:M2,1:M2);
D2Aug(2*M2+1:3*M2,2*M2+1:3*M2) = D2Aug(1:M2,1:M2);
end

