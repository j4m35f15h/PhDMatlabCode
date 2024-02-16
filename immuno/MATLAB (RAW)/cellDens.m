%First we import the cell data. Then we isolate the centres coordinates. We
%seed a 1024 by 1024 image with the centre coordinates. We calculate the
%average distance to 8 neighbours for all the cells (All of this should maintain indexing).
%We look at the bounds and use them to scale a color map. We assign each
%cell a color value. We triplicate the image to act as red blue green. We 
%look up the color value and store it for each cell's pixel. We then scan
%through all three images for a non zero value, and spread it to it's
%neighbours. We do this three times. 

%There shouldn't be a situation where an essential pixel is over written. 
%The expansion method means that when two cells meet, theyll cancel each 
%other out.
name = '12LSS3S3I4DAPICell.csv';
T = readtable(name);
res = 1.5152;
cellPos = [T.X,T.Y];
cellDensity = zeros(size(cellPos,1),1);
for i = 1:size(cellDensity,1)
%     shortcut = find((cellPos(:,1)-cellPos(i,1))<10);  
    temp = [cellPos(:,1) - cellPos(i,1)*ones(size(cellPos,1),1),...
            cellPos(:,2) - cellPos(i,2)*ones(size(cellPos,1),1)];
        temp = sqrt(temp(:,1).^2+temp(:,2).^2);
        I = sort(temp);
        cellDensity(i,1) = mean(I(2:5));        
end

%Ok we're doing htis quick and cheap. We'll do a red blue specturm. All we
%gotta do is find the proportion along the distance spectrum, then the blue
%channes is 255*1-proportion and the red channel is 255*proportion.
%Then we're just gonna stamp the image for each cell and do the big
%neighbourhood thing
newImage = zeros(1024,1024,3);
cellDensity = log(cellDensity);
temp = sort(cellDensity);
denseRange = [min(cellDensity),temp(end-2)-min(cellDensity)];
% denseRange = [0,1];
denseProportion = (cellDensity-denseRange(1))/denseRange(2);





for i = 1:size(cellDensity,1)
    tempCoord = cellPos(i,:)/res;
    tempCoord = round(tempCoord);
    tempCoord(1,2) = 1024-tempCoord(1,2);
    %tempColor = [255*denseProportion(i),0,255*(1-denseProportion(i))]
    tempColor = [255*(1-(3/4)*denseProportion(i)),255*(denseProportion(i)*(3/4) - 1),255*(1-2*abs(0.5-denseProportion(i)))];
    tempColor(tempColor<0) = 0;
    for j = 0:2
        for k = 0:2
            newImage(tempCoord(1)+j,tempCoord(2)+k,1) = tempColor(1);
            newImage(tempCoord(1)+j,tempCoord(2)+k,2) = tempColor(2);
            newImage(tempCoord(1)+j,tempCoord(2)+k,3) = tempColor(3);
        end
    end
       
end

newImage = newImage/255;
figure
imshow(newImage)
title(name)
view([-90 90]);