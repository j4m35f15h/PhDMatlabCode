function [growthMag,growthAnisotropy] = obtainGrowthMap(lattice,latticeNew,theta,cols)
%OBTAINGROWTHMAP Summary of this function goes here
%   The growth map has two major components; the growth magnitude and
%   anisotropy. In the literature, the growth map is obtained from the
%   deformation tensor. To obtain the deformation tensor we take a pair of
%   coordinates in the previous time fram and multiply them by the invers
%   of those same coordinates in the second time frame. The question
%   becomes, what do we do with the fact that we will have 4 tesors at each
%   point/on each square. It makes sense to do it on the points because if
%   we're pressed up agains the edge, the only available data would be
%   further away. I suppose we obtain the magnitude and anisotropy for each
%   of the tensors associated with a point, then average the values. The
%   small deformation criteria should minimise differences in those values.
N = size(lattice,2)/2;
growthMag = zeros(size(theta));
growthAnisotropy = zeros(3,size(theta,2));
% F = zeros(2,2,4);
for i = 1:size(theta,2) %for all the calculation domain
    [localO,~] = neighbours(theta(i),lattice,cols);
    [localN,~] = neighbours(theta(i),latticeNew,cols);
    xc = latticeNew(theta(i));
    yc = latticeNew(theta(i)+N);
    Xc = lattice(theta(i));
    Yc = lattice(theta(i) + N);
    for j = 1:4 %for all the directions around a point
        %Obtain old and new coordinates
        [x1,x2,y1,y2] = setCoordinates(j,localN);
        [X1,X2,Y1,Y2] = setCoordinates(j,localO);
        newC = [x1-xc,x2-xc;y1-yc,y2-yc];
        oldC = [X1-Xc,X2-Xc;Y1-Yc,Y2-Yc];
        F = newC/oldC; 
        growthMag(i) = growthMag(i) + (det(F))/4;%Calculate magnitude and store at that point. 
        %Calculate anisotropy and store at that point:
            %We have a bit of a split here as we need information about
            %what kind of values we end up getting. The idea is we need to
            %multiply F^T*F, then square root the resulting matrix. For
            %this, the matrix must be diagonal. If we arent' obtaining a
            %diagonal matrix, we need to rotate the matrix, square root
            %it, then rotate it back. There is a matlab function sqrtm but
            %we need to see if that is performing the process for us.
        U = sqrtm(F'*F);
        [V,D] = eig(U);
        if D(1,1) < D(2,2) %swap elements
            D(1,1) = D(1,1) - D(2,2);
            D(2,2) = D(2,2) + D(1,1);
            D(1,1) = D(2,2) - D(1,1);
            V = fliplr(V);
        end
        D = D/(sum([D(1,1),D(2,2)]));
        growthAnisotropy(1,i) = growthAnisotropy(1,i) + ((D(2,2)/D(1,1)))/4;
        growthAnisotropy(2:3,i) = growthAnisotropy(2:3,i) + V(:,1)/4;
    end
%     F = zeros(2,2,4);%Clear variable for next iteration
end
end

function [x1,x2,y1,y2] = setCoordinates(j,local)
if j == 4
    x1 = local(j);
    x2 = local(1);
    y1 = local(j + 4);
    y2 = local(5);
    return;
end
x1 = local(j);
x2 = local(j + 1);
y1 = local(j + 4);
y2 = local(j + 5);
end
