%OK so this will be our script to register all of the cell data. The
%process should be as follows. We provide a list of the file names. The
%first in the list will be the reference image to which the other samples
%are registered to. We'll need to produce the reference image. We use
%boundary to find an appropriate outline. We create a grid of arbitrary
%size. grid locations inside the boundary get a 1, outside get a zero. We
%now need to create the sample images. for every dataset in the list we
%find a boundary for the points. We create a fris of arbitrary size. Grid
%location inside the outline get a 1, locations outside get a -1. we trim
%the grid. We convolve the trimmed sample over the reference and find a
%maximum. We apply this transformation to the data of the sample. We then
%rotate the sample's data about it's centroid, creating new images, and
%convolve in place with that image and find a maximum. With the new rotated
%sample, we convolve to find a new maximum. Apply this transform to the
%data, try new rotations and repeat till minimum in rotation and
%transformation.

%Addendum, we find that the fit isn't ideal. what we're going to do is
%change the sample images such that the error slowly increases the further
%away from the outline. We can do this my multiplying the negative values
%by the distance from the centre, since the centroid of the data shoulbe be
%at the centre.

%We provide a list of the file names. 
% regList = ["12LSS3S3I4DAPICell.csv"];
regList = dir('\\rds.imperial.ac.uk\rds\project\nowlan_group_data\live\James\septemberExp20\FIGURES\Static\D2\0p');

%Somehow the code for the reference image has dissapeared. Now since all of
%the images are different sizes, We should really start with the large one,
%then run the search on the smallest. Also I think we should exagerate the
%values on the sample images so that both the positive and negative regions
%have roughly the same value. can do with find and numel

%Load data into a base struct
for i = 3:size(regList,1)
T = readtable(regList(i).name);
    dataStruct(i-2).data = [T.X,T.Y];
    if regList(i).name(2) == 'L' || regList(i).name(3) == 'L'
        dataStruct(i-2).data(:,2) = -dataStruct(i-2).data(:,2);
    end
end
%Find the one with the biggest range, then switch it's position with the
%first do that the rest of the code still semi works.
    bigRange = zeros(1,2);
for i = 1:size(dataStruct,2)
    temp = range(dataStruct(i).data(:,1))*range(dataStruct(i).data(:,2));
    if temp-bigRange(1) > 0
        bigRange(1) = temp;
        bigRange(2) = i;
    end
end

temp = dataStruct(1).data;
dataStruct(1).data = dataStruct(bigRange(2)).data;
dataStruct(bigRange(2)).data = temp;
%Now we create the reference image from the first of the data
k = boundary(dataStruct(1).data);

    refImBound = [min(dataStruct(1).data(:,1))-100,max(dataStruct(1).data(:,1))+100, ...
        min(dataStruct(1).data(:,2))-100,max(dataStruct(1).data(:,1))+100];
    %Grid location inside the outline get a 1, locations outside get a -1.
    [xIm,yIm] = meshgrid([refImBound(1):refImBound(2)],[refImBound(3):refImBound(4)]);
    referenceImage = ones(size(xIm))*-1;
    for m = 1:size(xIm,1)      %could Probably vectorize this
        for j = 1:size(xIm,2)
            referenceImage(m,j) = inpolygon(xIm(m,j),yIm(m,j) , dataStruct(1).data(k,1),dataStruct(1).data(k,2));
        end
    end
%we trim t

%We now need to create the sample images. 
%for every dataset in the list we find a boundary for the points.
 for i = 4%2:size(dataStruct,2)
    i
%     T = readtable(regList(i).name);
%     samplePos = [T.X,T.Y];
%     if regList(i).name(2) == 'L' || regList(i).name(3) == 'L'
%         samplePos(:,2) = -samplePos(:,2);
%     end
    samplePos = [dataStruct(i).data(:,1),dataStruct(i).data(:,2)];
    k = boundary(samplePos);
    
% %     % We create a grid of arbitrary size.
% %     sampleImBound = [min(samplePos(:,1))-10,max(samplePos(:,1))+10, ...
% %         min(samplePos(:,2))-10,max(samplePos(:,1))+10];
% %     %Grid location inside the outline get a 1, locations outside get a -1.
% %     [xIm,yIm] = meshgrid([sampleImBound(1):sampleImBound(2)],[sampleImBound(3):sampleImBound(4)]);
% %     sampleImage = ones(size(xIm))*-1;
% %     for m = 1:size(xIm,1)      %could Probably vectorize this
% %         for j = 1:size(xIm,2)
% %             if inpolygon(xIm(m,j),yIm(m,j) , samplePos(k,1),samplePos(k,2))
% %                 sampleImage(m,j) = 1;
% %             end
% %         end
% %     end
% % %we trim the grid. 
% % %We convolve the trimmed sample over the reference and find a maximum. 
% % temp = conv2(referenceImage,sampleImage);
% % [m1,iRows] = max(temp);
% % [m2,iCol] = max(m1);
% % iRow = iRows(iCol); %iCol,iRow are the row and col of the maximum in the convolution

%Need to find the true ofset. This is the bottom left pixel of the
%reference image + resolution times pixel number.
%We apply this transformation to the data of the sample. 
% samplePos(:,1) = samplePos(:,1) + ones(size(samplePos(:,1)))*(refImBound(1) + iCol - sampleImBound(1));
% samplePos(:,2) = samplePos(:,2) + ones(size(samplePos(:,1)))*(refImBound(3) + iRow - sampleImBound(3));

%We then rotate the sample's data about it's centroid, creating new images, and
%convolve in place with that image and find a maximum. 
% centroidX = min(samplePos(:,1)) + range(samplePos(:,1))/2;
% centroidY = min(samplePos(:,2)) + range(samplePos(:,2))/2;
% tempSampleB = samplePos(size(k,1),:) - [ones(size(k,1),1)*centroidX,ones(size(k,1),1)*centroidY];
tempSampleB = samplePos;
tempResult = [];
for thetad = -135:45:180
    thetad
% thetad = 5;
R  = [cosd(thetad) -sind(thetad); sind(thetad) cosd(thetad)];
tempSamplePos = tempSampleB*R;
k = boundary(tempSamplePos);
% tempSamplePos = tempSamplePos + [ones(size(samplePos,1),1)*centroidX,ones(size(samplePos,1),1)*centroidY];
%Need to produce a new image,k should stay the same despoite the
%transformation- copioed from above

sampleImBound = [min(tempSamplePos(:,1))-10,max(tempSamplePos(:,1))+10, ...
                    min(tempSamplePos(:,2))-10,max(tempSamplePos(:,2))+10];
%Grid location inside the outline get a 1, locations outside get a -1.
[xIm,yIm] = meshgrid([sampleImBound(1):sampleImBound(2)],[sampleImBound(3):sampleImBound(4)]);
sampleImage = ones(size(xIm))*-1;
for m = 1:size(sampleImage,1)
    for j = 1:size(sampleImage,2)
        sampleImage(m,j) = sampleImage(m,j)*sqrt((m-size(sampleImage,1)/2)^2 +(j- size(sampleImage,1)/2)^2);
    end
end
tempSum = abs(mean(mean(sampleImage)));
for m = 1:size(xIm,1)      %could Probably vectorize this
    for j = 1:size(xIm,2)
        if inpolygon(xIm(m,j),yIm(m,j) , tempSamplePos(k,1),tempSamplePos(k,2))
            sampleImage(m,j) = 1*tempSum;
        end
    end
end
% temp = conv2(referenceImage,sampleImage);
% [m1,iRows] = max(temp);
% [m2,iCol] = max(m1);
% iRow = iRows(iCol);
% 
% tempResult = [tempResult,m2];

temp2 = filter2(sampleImage,referenceImage,'valid');
[m1,iRows] = max(temp2);
[m2,iCol] = max(m1);
iRow = iRows(iCol);
tempTrans = [tempTrans,[iRow;iCol]];
tempResult = [tempResult,m2];

end

toc%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%Fine angle correction

%We then rotate the sample's data about it's centroid, creating new images, and
%convolve in place with that image and find a maximum. 
% centroidX = min(samplePos(:,1)) + range(samplePos(:,1))/2;
% centroidY = min(samplePos(:,2)) + range(samplePos(:,2))/2;
% tempSampleB = samplePos(k,:) - [ones(size(k,1),1)*centroidX,ones(size(k,1),1)*centroidY];

[~,I] = max(tempResult);
temp = -135:45:180;
% tempResult = [];
% tempTrans = [];
% for thetad = (temp(I)-10)%:5:(temp(I)+10)
% % thetad = 5;
% R  = [cosd(thetad) -sind(thetad); sind(thetad) cosd(thetad)];
% tempSamplePos = samplePos*R;
% k = boundary(tempSamplePos);
% % tempSamplePos = tempSamplePos + [ones(size(samplePos,1),1)*centroidX,ones(size(samplePos,1),1)*centroidY];
% %Need to produce a new image,k should stay the same despoite the
% %transformation- copioed from above
% 
% sampleImBound = [min(tempSamplePos(:,1))-10,max(tempSamplePos(:,1))+10, ...
%                     min(tempSamplePos(:,2))-10,max(tempSamplePos(:,2))+10];
% %Grid location inside the outline get a 1, locations outside get a -1.
% [xIm,yIm] = meshgrid([sampleImBound(1):sampleImBound(2)],[sampleImBound(3):sampleImBound(4)]);
% sampleImage = ones(size(xIm))*-1;
% for m = 1:size(sampleImage,1)
%     for j = 1:size(sampleImage,2)
%         sampleImage(m,j) = sampleImage(m,j)*sqrt((m-size(sampleImage,1)/2)^2 +(j- size(sampleImage,1)/2)^2);
%     end
% end
% tempSum = abs(mean(mean(sampleImage)));
% for m = 1:size(xIm,1)      %could Probably vectorize this
%     for j = 1:size(xIm,2)
%         if inpolygon(xIm(m,j),yIm(m,j) , tempSamplePos(k,1),tempSamplePos(k,2))
%             sampleImage(m,j) = 1*tempSum;
%         end
%     end
% end
% temp2 = filter2(sampleImage,referenceImage,'valid');
% [m1,iRows] = max(temp2);
% [m2,iCol] = max(m1);
% iRow = iRows(iCol);
% tempTrans = [tempTrans,[iRow;iCol]];
% tempResult = [tempResult,m2];
% 
% end
% 
% [~,I] = max(tempResult);
% temp = (temp(I)-10):5:(temp(I)+10);
angleCorr = temp(I);
transCorr = tempTrans(:,I);
%At this point we should have a good fit with a good angle. Now we apply
%that to the original data set and store these new values.

%coordinates,centroided to zero,rotated,add reference corner coordinate,add
%row and col increments.

centroidX = min(samplePos(:,1)) + range(samplePos(:,1))/2;
centroidY = min(samplePos(:,2)) + range(samplePos(:,2))/2;
samplePos = samplePos - [ones(size(samplePos,1),1)*centroidX,ones(size(samplePos,1),1)*centroidY];

trueR =  [cosd(angleCorr) -sind(angleCorr); sind(angleCorr) cosd(angleCorr)];
samplePos = samplePos*R;

samplePos(:,1) = samplePos(:,1) + ones(size(samplePos(:,1)))*(refImBound(4) - transCorr(2) + -1*(centroidX - sampleImBound(4)));
samplePos(:,2) = samplePos(:,2) + ones(size(samplePos(:,1)))*(refImBound(2) - transCorr(1) + -1*(centroidX - sampleImBound(2)));

%This should provide us with the cell positions corrected to the right
%position and rotation. Next we need to store them in some sort of large
%data structure. This structure won't have a fixed data size which is ugly.

cellPosStruct(i).data = samplePos;

%Alternatively, we can rotate the image clasically then perform an
%expansion and erosion to fill in any gaps. This rotation should be
%performed from the original image, and not the previous rotation as that
%may cause a degradation off shape over time.

%find will give us the row and col values of the image. We rotate These
%values, and recreate the image by doing something similar to what we did
%originally.

%With the new rotated
%sample, we convolve to find a new maximum. Apply this transform to the
%data, try new rotations and repeat till minimum in rotation and
%transformation.
 end
 cellPosStruct(1).data = dataStruct(1).data;