%This is going to allow for the co-localiosation of the cells. At this point,
%we should have point clouds associated with the cells before and after.
%We're going to take the coordinates, represent them with scatter, and 
%provide the user with a way to check the correspondance of cells.

%Code to apply the transformation?, assume we have access to cell coords.

cellsPre = dataStruct.cellCoordPre;
cellsPost = dataStruct.cellCoordPost;

%Take the post cells and add an offset so that their centroids are the same

avgPre = mean(cellsPre,2);
cellsPost = cellsPost-ones(size(cellsPost,1),1)*(mean(cellsPost,2) -avgPre);

%We can make a quick assumption that the rotation experience by the cells is minimal.
%If the neighbourhood is small, and we assume that the spatial variance in the
%growth is small, the amount of rotation should be minimal.

matches = zeros(size(cellsPre,1),5);
for i = 1:size(cellsPre,1)
[~,I] = sort(sum((cellsPost - ones(size(cellsPost,1),1)*cellsPre(:,i)).^2),2);
matches(i,:) = I(1:5);
end

%This should provide us with the five closest cells for each of the
%start point cells. From this, we want to find a combination that creates
% the smallest divergence for all of the cells

%That would be the most basic form, the more complicated auomatic co-register
%would attempt to find a correspondence that creates a consistent transformation

%method 1:
% Look through the list and see duplicates.

[v, w] = unique( matches(:,1), 'stable' );
dupInd = setdiff( 1:numel(A), w );
if ~isnull(dupInd)
    for i = 1:size(dupInd,2)
        iStack = [];
        matchInd = find(matches(:,1)==matches(dupInd(i),1));
        ps = perms(1:size(matchInd,2));
        for j = 1:size(matchInd,2)
            iStack = [iStack,matches(ones(size(perms,1),1)*matchInd(1,j),perms(:,j))];
        end
        %We now have the indeices of the cells in the second time point
        %now we need to take the absolute distance from the cells in the
        %first time point. then add the abs ditance for each row and then
        %shoose the one with the lowest then use that permutation row to re
        %-index the matches
        sumDist = zeros(size(ps,1),1);
        for k = 1:size(iStack,1)
            for l = 1:size(istack,2)
                sumDist(k,1) = sqrt(sum((cellsPost(iStack(k,l),:) - cellsPre(matchIndex(1,l),:)).^2));
            end
        end
        [~,I] = sort(sumDist);
        cP = ps(I,:);
        matches(matchInd,1) = deal(cP);
    end
end

%         if duplicates do stuff
%             stuff: take the n offenders (hopefully n is less than 5)
%             find which offender combination has the smallest total length
%             generate all permutations of n elements.
%             find permutation which minimises the abs sum
%             reasign matches
%         end

        %I don't know how well that's going to work. I think what is going to be
%more successful is finding on or two that are easy to identify, then
% saying that the corresponding match is the one that allows for  the smallest 
%transform variance. 

%Method 2: What that will look like

%Let's say that at this point, we have one corresponmdence that we're 
%certain of:

% Find the transform the corresponds to the change in position relative to the centroid
% for each other point, predict their position
% Find the five nearest cells/nearest cell to this position.

estTransform = (cellsPost(givenMatch(1,2)) - mean(cellsPost,2))./(cellsPre(givenMatch(1,1),:) - avgPre);%Contains the indecices in pre and post cells that correspond tothe initial match
for i = 1:size(cellsPre,1)
    postEst(i,:) = cellsPre(i,:).*estTransform;
end

matches = zeros(size(cellsPre,1),5);
for i = 1:size(cellsPre,1)
[~,I] = sort(sum((cellsPost - ones(size(cellsPost,1),1)*postEst(:,i)).^2),2);
matches(i,:) = I(1:5);
end
% if duplicates do stuff
% stuff: take the n offenders (hopefully n is less than 5)
% 	find which offender combination has the smallest total length
% 	generate all permutations of n elements.
% 	find permutation which minimises the abs sum
% 	reasign matches
% end

[v, w] = unique( matches(:,1), 'stable' );
dupInd = setdiff( 1:numel(A), w );
if ~isnull(dupInd)
    for i = 1:size(dupInd,2)
        iStack = [];
        matchInd = find(matches(:,1)==matches(dupInd(i),1));
        ps = perms(1:size(matchInd,2));
        for j = 1:size(matchInd,2)
            iStack = [iStack,matches(ones(size(perms,1),1)*matchInd(1,j),perms(:,j))];
        end
        %We now have the indeices of the cells in the second time point
        %now we need to take the absolute distance from the cells in the
        %first time point. then add the abs ditance for each row and then
        %shoose the one with the lowest then use that permutation row to re
        %-index the matches
        sumDist = zeros(size(ps,1),1);
        for k = 1:size(iStack,1)
            for l = 1:size(istack,2)
                sumDist(k,1) = sqrt(sum((cellsPost(iStack(k,l),:) - postEst(matchIndex(1,l),:)).^2));
            end
        end
        [~,I] = sort(sumDist);
        cP = ps(I,:);
        matches(matchInd,1) = deal(cP);
    end
end

dataStruct.matches = matches;
% Code to visualise the matches?
% Could do it with a ui window?
% scatter plot all points (2 separate plots? If we want 1, we'll have to use im2vol)
% scatter fill the points in question
% slider below moves us through which ones are filled
% %Let's the user check if the estimate was good
% %Need a way for the user to change the match.
% Change match button finds the list of cells which were close
% another button moves through that list
% another button changes the correspondence to this pair.
% Button to exit.

