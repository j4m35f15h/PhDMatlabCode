function [D1,B1] = B1Process(B1Aug,f1,theta)
%   The processing function is supposed to take in the expanded B1 and
%   separate it into the D matrix and the true B1. To do this, it needs to
%   take the row values that correspond to border points and delete them D1.
%   Then it needs to take column values for border points for the remaining
%   rows and set them to the appropriate rows in the B1 matrix, and finally
%   delete them in the first matrix. What is left behind is D1.
M1 = size(theta,2);
M2 = size(f1,2);
D1 = zeros(2*M1,2*M1);
B1 = zeros(2*M1,2*M2);

%It makes sense to copy the values over, then delete the appropriate
%elements
for i = 1:size(B1Aug,2)
    for j = 1:size(B1Aug,1)
        if ismember(j,theta)*ismember(i,theta)
            D1((j==theta),(i==theta)) = B1Aug(j,i);
        end
        if ismember(j,theta)*ismember(i,f1)
            B1((j==theta),(i==f1)) = -B1Aug(j,i);
        end
    end
end
%Just need to reflect the matrices now.
D1(M1+1:end,M1+1:end) = D1(1:M1,1:M1);
B1(M1+1:end,M2+1:end) = B1(1:M1,1:M2);
end

