function [D3,B3] = B3Solve3D(f2,f3,lattice,cols,rows)
% %B2SOLVE3D Summary of this function goes here
% %   Detailed explanation goes here
% M2 = size(f2,2);
% M3 = size(f3,2);
% D2Aug = zeros(3*M2,3*M2);
% B2 = zeros(3*M2,3*M3);
% for i = 1:size(f2,2)
%     [~,localIndex] = neighbours3D(f2(i),lattice,cols,rows);
%     temp = localIndex(find(ismember(localIndex,f2)));
%     if size(temp,2) < 4
%         tempNeg = localIndex(find(ismember(localIndex,theta)));
%         for j = 1:size(tempNeg,2)
%             [~,localIndex] = neighbours3D(tempNeg(j),lattice,cols,rows);
%             temp = [temp,localIndex(find(ismember(localIndex,f2)))];
%         end
%     end
%     temp = unique(temp);
%     temp(find(temp==f2(i))) = [];
%     localIndex = temp;
%     val = 1/(sum(ismember(localIndex,f2)));
% 
%     for j = 1:size(localIndex,2)
%         if ismember(localIndex(j),f3)
%             B2(i,find(f3==localIndex(j))) = val;
%             continue;
%         end
%         if ismember(localIndex(j),f2)
%             D2Aug(i,find(f2==localIndex(j))) = -val;
%         end
%     end
%     D2Aug(i,i) = 1;
% end
% 
% %At This point, we have a matrix that uss all of the boundary points. We
% %now need to diminish the matix into just the bounday points, and the edges
% %of the boundary. I can assume that we use the first and last point.
% % for i = 2:M2-1
% %     B2(i-1,1) = D2Aug(i,1);
% %     B2(i-1,2) = D2Aug(i,M2);
% % end
% B2(M2+1:2*M2,M3+1:2*M3) = B2(1:M2,1:M3);
% B2(2*M2+1:3*M2,2*M3+1:3*M3) = B2(1:M2,1:M3);
% 
% D2 = zeros(3*M2,3*M2);
% D2(1:M2,1:M2) = D2Aug(1:M2,1:M2);
% D2(M2+1:2*M2,M2+1:2*M2) = D2(1:M2,1:M2);
% D2(2*M2+1:3*M2,2*M2+1:3*M2) = D2(1:M2,1:M2);

%I'm pretty sure we need to code this from scratch, mu1 represents the
%smoothness of internal deformation, mu2 represents the smoothness of
%surface (for which f2 is the four points on the back side) and mu3
%represents the smoothness of the line bordering the four f2 points. This
%means that this function is supposed to provide the coefficients for the
%avgergagin like the last one was in the 2D model. The means we need to
%look at a point in f2, for all points in f2, and find it's two neighbours.
%We place all of the coefficients into a big augmented matrix, then we can
%separate them out later at the end. Since we're just doing the 1D line
%thing, we just need to put 0.5s in the indices that corres[pond to the
%right points. I'm certain that there is code that we've written earlier
%that can be used to do this quite easily.
% B3Aug = zeros(size(lattice,2),size(lattice,2));
% for i = 1:size(f2,2)
%     B3Aug(f2(i),f2(i)) = 1;
%     [~,localIndex] = neighbours3D(f2(i),lattice,cols,rows);
%     for j = 1:size(localIndex,2)
%         if ismember(localIndex(j),f3)
% %             'Ping2'
% %             f3(ismember(localIndex(j),f3))
%             B3Aug(f2(i),f3(ismember(f3,localIndex(j)))) = -0.5;
%             continue;
%         end
%         if ismember(localIndex(j),f2)
%             B3Aug(f2(i),f2(ismember(f2,localIndex(j)))) = 0.5;
%         end
%     end
% end
% D3 = B3Aug(f2,f2);
% B3 = B3Aug(f2,f3);

%Gotta be a simpler way of doing this.
M3 = size(f2,2);
M4 = size(f3,2);
D3 = zeros(3*M3,3*M3);
B3 = zeros(3*M3,3*M4);
D3(1:1+size(D3,1):end) = 1;
for i = 1:M3
    [~,localIndex] = neighbours3D(f2(i),lattice,cols,rows);
    for j = 1:size(localIndex,2)
        if ismember(localIndex(j),f3)
            B3(i,ismember(f3,localIndex(j))) = 0.5;
            continue;
        end
        if ismember(localIndex(j),f2)
            D3(i,ismember(f2,localIndex(j))) = -0.5;
        end
    end
end

D3(M3+1:2*M3,M3+1:2*M3) = D3(1:M3,1:M3);
D3(2*M3+1:3*M3,2*M3+1:3*M3) = D3(1:M3,1:M3);

B3(M3+1:2*M3,M4+1:2*M4) = B3(1:M3,1:M4);
B3(2*M3+1:3*M3,2*M4+1:3*M4) = B3(1:M3,1:M4);
%Now we need to separate out the augmented array into the two smaller ones.
%Each row of the arrays corresponds to elements of f2, and in D3, each
%column corresponds to an element of f2. Because of this, the diagonal
%elements of d£ should all be one when we're done with it. In the case of
%B3, each row likewise corresponds to an element of f2 but each column
%corresponds to an element of f3.
end

