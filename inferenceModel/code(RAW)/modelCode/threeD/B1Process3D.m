function [D1,B1] = B1Process3D(B1Aug,f1,theta)
%B1PROCESS Summary of this function goes here
%   The processing function takes in the expanded B1 
%   and separates it into the D1 matrix and the true B1. To do this, it 
%   takes the row values that correspond to border points and deletes them from D1.
%   Then it takes column values for border points for the remaining
%   rows and set them to the appropriate rows in the B1 matrix, and finally
%   delete them in the first matrix. What is left behind is D1.
M1 = size(theta,2);
M2 = size(f1,2);
D1 = zeros(3*M1,3*M1);
B1 = zeros(3*M1,3*M2);

%It makes sense to copy the values over, then delete the appropriate
%elements
for i = 1:size(B1Aug,2) %For all the members of the augmented B1 matrix
    %i
    for j = 1:size(B1Aug,1)
        if ismember(j,theta)&&ismember(i,theta) % if row&col indices are in theta
            D1(find(theta==j),find(theta==i)) = B1Aug(j,i);
        end
        if ismember(j,theta)&&ismember(i,f1) % if row&col indices are in boundary
            B1(find(theta==j),find(f1==i)) = -B1Aug(j,i);
        end
    end
end

%Copy the matrices for the other dimensions.
D1(M1+1:2*M1,M1+1:2*M1) = D1(1:M1,1:M1);
D1(2*M1+1:end,2*M1+1:end) = D1(1:M1,1:M1);

B1(M1+1:2*M1,M2+1:2*M2) = B1(1:M1,1:M2);
B1(2*M1+1:end,2*M2+1:end) = B1(1:M1,1:M2);
end

