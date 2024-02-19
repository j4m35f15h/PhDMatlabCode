%!!!!!!!!!!!!!!!!!!!!!You will need to change this!!!!!!!!!!!!!!!!!!!!!!!!
%Provide the file output location, as well as how you would like to create
%the data struct. Set to 1 for a default construction, set to 2 for a
%manual input of all fields
fileOutputDestination = '\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\all2gether\cellStorage';
inputMethod = 1


%The data struct used to contain the information has the following fields:
% Limb name
% Global image pre
% transformationGlobal
% Local image pre
% Zoom pre
% Cell Coordinates pre
% Global image post
% transformationGlobal Post
% local Image post
% zoom post
% Cell coordinates post

%This program will help the user make the struct, as well as automatically
%store it.
dataStruct = [];
if inputMethod == 1
    dataStruct.limbName = '22R';
    
    dataStruct.gImagePre = 'globalRed.tif';
    dataStruct.transPre = zeros(1,6);
    tiff_info = imfinfo(dataStruct.gImagePre); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.gImagePre, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.gImagePre, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.gImagePre = tiff_stack;
    
    dataStruct.xRes = 3.019; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dataStruct.yRes = 3.019; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    dataStruct.zRes = 11.4114; %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    dataStruct.lImagePre = 'zoomRed.tif';
    tiff_info = imfinfo(dataStruct.lImagePre); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.lImagePre, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.lImagePre, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.lImagePre = tiff_stack;
    
    dataStruct.zoomPre = 3.698;
    
    dataStruct.cellCoordPre = [];
    dataStruct.cellCoordPreTrans = [];
    
    dataStruct.gImagePost = [];
    dataStruct.transPost = [];
    
    dataStruct.lImagePost = [];
    dataStruct.zoomPost = 1;
    dataStruct.cellCoordPost = [];
    dataStruct.cellCoordPostTrans = [];
    
elseif inputMethod == 2
    dataStruct.limbName = input('Enter the name of the limb: ');
    
    dataStruct.gImagePre = input('Enter the file location of the global image stack pre-culture: ');
    tiff_info = imfinfo(dataStruct.gImagePre); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.gImagePre, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.gImagePre, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.gImagePre = tiff_stack;
    
    dataStruct.transPre = zeros(1,6);
    
    dataStruct.lImagePre = input('Enter the file location of the zoomed image stack pre-culture: ');
    tiff_info = imfinfo(dataStruct.lImagePre); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.lImagePre, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.lImagePre, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.lImagePre = tiff_stack;
    
    dataStruct.zoomPre = input('Enter the zoom value: ');
    dataStruct.cellCoordPre = [];
    dataStruct.cellCoordPreTrans = [];
    
    dataStruct.gImagePost = input('Enter the file location of the global image stack post-culture: ');
    tiff_info = imfinfo(dataStruct.gImagePost); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.gImagePost, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.gImagePost, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.gImagePost = tiff_stack;
    
    dataStruct.transPost = zeros(1,6);
    
    dataStruct.lImagePost = input('Enter the file location of the zoomed image stack post-culture: ');
    tiff_info = imfinfo(dataStruct.lImagePost); % return tiff structure, one element per image
    tiff_stack = imread(dataStruct.lImagePost, 1) ; % read in first image
    %concatenate each successive tiff to tiff_stack
    for ii = 2 : size(tiff_info, 1)
        temp_tiff = imread(dataStruct.lImagePost, ii);
        tiff_stack = cat(3 , tiff_stack, temp_tiff);
    end
    dataStruct.lImagePost = tiff_stack;
    
    dataStruct.zoomPost = input('Enter the zoom value: ');
    dataStruct.cellCoordPost = [];
    dataStruct.cellCoordPostTrans = [];
end
