%This is the final step before running the model itself. We have the
%transforms that register the limbs, now we just need to apply them to the
%start and end coordinates. We'll deal with any scale issues after this
%step. We need to:
clear ModelInputStructDyn
clear ModelInputStructStat

ModelInputStructDyn.LimbName = [];
ModelInputStructDyn.CB = [];
ModelInputStructDyn.CA = [];

%Get a listing for the Cells in the Dyn/stat group
temp = dir('limbCoordinate\Dyn');
addpath(genpath('limbCoordinate\Dyn'))
%Add the first one to the path
addpath(genpath('EndG'))
for i = 3:size(temp,1)
    %Add the same folder in the StartG and EndG folders to the path
    listing = temp(i).name;
    %load the end transform data
    try
        load([listing,'\transformG.mat'])
    catch
        ModelInputStructDyn(i).LimbName = listing;
        continue
    end
    
    %Load the cell after coordinates
    try
        load(['Dyn\',listing,'\CA.mat'])
    catch
        ModelInputStructDyn(i).LimbName = listing;
        continue
    end
    %Subtract the origin, multiply by rot matrix, add origin, add the offset
        %For the first one, we should aklso look at the transformed stl and
        %cell coordinates just to make sure its doing what we think it is.
    M(:,1) = -M(:,1);
    M(:,3) = M(:,3)*dataStruct.transPre(4);
    
    temp2 = dataStruct.transOrigin;
    temp2(1) = -temp2(1);
    temp2(3) = temp2(3)*dataStruct.transPre(4);
   
    M = M - temp2;
    M = [dataStruct.transRot*M']';
    M = M + temp2;
    M = M + dataStruct.transPre(1:3);
    ModelInputStructDyn(i).LimbName = listing;
    ModelInputStructDyn(i).CA = M;
    %Add new data and old data to struct
    %Specimen label, cells before, cells after
    %Move on to next listing
end
%remove EndG folder from path
rmpath(genpath('EndG'))
%add startG folder to path
addpath(genpath('StartG\Dyn'))
for i = 3:size(temp,1)
    %Add the same folder in the StartG and EndG folders to the path
    listing = temp(i).name;
    %load the end transform data
    try
        load([listing,'\transformG.mat'])
    catch
        ModelInputStructDyn(i).LimbName = listing;
        continue
    end
    %Load the cell after coordinates
    try
        load(['Dyn\',listing,'\CB.mat'])
    catch
        ModelInputStructDyn(i).LimbName = listing;
        continue
    end
    
    %Subtract the origin, multiply by rot matrix, add origin, add the offset
        %For the first one, we should aklso look at the transformed stl and
        %cell coordinates just to make sure its doing what we think it is.
    M(:,1) = -M(:,1);
    M(:,3) = M(:,3)*dataStruct.transPre(4);
    
    temp2 = dataStruct.transOrigin;
    temp2(1) = -temp2(1);
    temp2(3) = temp2(3)*dataStruct.transPre(4);    
        
    M = M - temp2;
    M = [dataStruct.transRot*M']';
    M = M + temp2;
    
    M = M + dataStruct.transPre(1:3);
%     ModelInputStruct(i).LimbName = listing';
    ModelInputStructDyn(i).CB = M;

    %Move on to next listing
end
rmpath(genpath('StartG\Dyn'))

%Load the cell before coordinates
%load the start transform
%apply the trandformation as described above

ModelInputStructStat.LimbName = [];
ModelInputStructStat.CB = [];
ModelInputStructStat.CA = [];

%Get a listing for the Cells in the Dyn/stat group
temp = dir('limbCoordinate\Stat');
addpath(genpath('limbCoordinate\Stat'))
%Add the first one to the path
addpath(genpath('EndG'))
for i = 3:size(temp,1)
    %Add the same folder in the StartG and EndG folders to the path
    listing = temp(i).name;
    %load the end transform data
    try
        load([listing,'\transformG.mat'])
    catch
        ModelInputStructStat(i).LimbName = listing;
        continue
    end
    
    %Load the cell after coordinates
    try
        load(['Stat\',listing,'\CA.mat'])
    catch
        ModelInputStructStat(i).LimbName = listing;
        continue
    end
    %Subtract the origin, multiply by rot matrix, add origin, add the offset
        %For the first one, we should aklso look at the transformed stl and
        %cell coordinates just to make sure its doing what we think it is.
        M(:,1) = -M(:,1);
        M(:,3) = M(:,3)*dataStruct.transPre(4);
                
        temp2 = dataStruct.transOrigin;
        temp2(1) = -temp2(1);
        temp2(3) = temp2(3)*dataStruct.transPre(4);
        
        M = M - temp2;
        M = [dataStruct.transRot*M']';
        M = M + temp2;

        M = M + dataStruct.transPre(1:3);
        ModelInputStructStat(i).LimbName = listing;
        ModelInputStructStat(i).CA = M;
    %Add new data and old data to struct
    %Specimen label, cells before, cells after
    %Move on to next listing
end
%remove EndG folder from path
rmpath(genpath('EndG'))
%add startG folder to path
addpath(genpath('StartG\Stat'))
for i = 3:size(temp,1)
    %Add the same folder in the StartG and EndG folders to the path
    listing = temp(i).name;
    %load the end transform data
    try
        load([listing,'\transformG.mat'])
    catch
        ModelInputStructStat(i).LimbName = listing;
        continue
    end
    %Load the cell after coordinates
    try
        load(['Stat\',listing,'\CB.mat'])
    catch
        ModelInputStructStat(i).LimbName = listing;
        continue
    end
    
    %Subtract the origin, multiply by rot matrix, add origin, add the offset
        %For the first one, we should aklso look at the transformed stl and
        %cell coordinates just to make sure its doing what we think it is.
    M(:,1) = -M(:,1);
    M(:,3) = M(:,3)*dataStruct.transPre(4);
    
    temp2 = dataStruct.transOrigin;
    temp2(1) = -temp2(1);
    temp2(3) = temp2(3)*dataStruct.transPre(4);    
        
    M = M - temp2;
    M = [dataStruct.transRot*M']';
    M = M + temp2;
    M = M + dataStruct.transPre(1:3);
%     ModelInputStruct(i).LimbName = listing';
    ModelInputStructStat(i).CB = M;

    %Move on to next listing
end
rmpath(genpath('StartG\Stat'))