%The Slicer script takes in a folder consisting of a number of stl files
%and creates a series of images describing the transverse slices of an
%average shape. These slices need to be segmented in your preferred
%segmentation software.

% %Load in all of the overlayed meshes of the stage.
foldername = 'D2Dyn';
folderpath   = 'R:\live\James\septemberExp20\';
listing = dir([folderpath,foldername]);
addpath([folderpath,foldername]);

%Initialise composite
composite.vertices = [];
composite.faces = [];
temp.vertices = [];
composite.vindex = 0;
composite.findex = 0;
temp.faces = [];

templist = {listing.name};
composite.index = 0;
for i = 3:size(templist,2)
    [temp.vertices,temp.faces] = stlread(templist{i});
    
    composite.vertices = [composite.vertices;temp.vertices];
    composite.faces = [composite.faces;temp.faces];
    composite.vindex = [composite.vindex,size(composite.vertices,1)];
    composite.findex = [composite.findex,size(composite.faces,1)];
    %composite.(v/f)index represents the index that separates the list of
    %vertices into their different segments.
end

%Break down into composite into different depths
sliceDepths = [min(composite.vertices(:,3)),max(composite.vertices(:,3))];
sliceRes = diff(sliceDepths)/99; 

%Scaling selectivity - Triangulation may be uneven (i.e. lower res for flat surfaces, higher res for curved surfaces)
sliceResScale = [1.4*ones(1,50),1*ones(1,50)];

%Resact depth ranges into depth increments
sliceDepths = [sliceDepths(1):sliceRes:sliceDepths(2)];

%Initialise final outline
trueOutline = NaN(2000,2,size(composite.vindex,2)-1);

for i = 1:size(sliceDepths,2) %For each depth
    outlineHold = trueOutline;
    trueOutline = NaN(2000,2,size(composite.vindex,2)-1);
    for j = 1:size(composite.vindex,2)-1 % for each member of the composite
        %Initialse regions - Necessary for concavities in transverse plane
        region1 = [];
        region2 = [];
        
        %Indexes for specific organ
        organSel = [composite.vindex(j)+1:composite.vindex(j+1)];
        
        %Find mesh vertices at the right depth, with a scaled inaccuracy
        temp = find(abs(composite.vertices(organSel,3)-sliceDepths(i))<(sliceRes/sliceResScale(i)));
        
        if isempty(temp)
            continue
        end
        if size(temp,1)<60
            continue
        end
        
        %An example of region selection:
        if j == 1 %For organ one...
            %...The centre location of the concavity was ~525 units in x
            region1 = find(composite.vertices(organSel(temp),1)<530);
            region2 = find(composite.vertices(organSel(temp),1)>520);
        elseif j==2 %For organ two...
            %...The centre location was ~540 units in x
            region1 = find(composite.vertices(organSel(temp),1)<545);
            region2 = find(composite.vertices(organSel(temp),1)>535);
        elseif j==3
            region1 = find(composite.vertices(organSel(temp),1)<540);
            region2 = find(composite.vertices(organSel(temp),1)>530);
        else
            region1 = find(composite.vertices(organSel(temp),1)<545);
            region2 = find(composite.vertices(organSel(temp),1)>535);
        end

% %     Error check - Show individual limbs in this layer and plot oulines found
%     figure
%     hold on
%     scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
%     k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.6);
%     plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
%     k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
%     plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
%     hold off
        
        %Sets the shrink factor for the native MATLAB boundary function
        region1coef = 0.3;
        region2coef = 0.3;

        %Plot to check the shrink factor is correct
%         figure
%         hold on
%         scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
%         k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),region1coef);
%         plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
%         k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),region2coef);
%         plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
%         hold off
        %
        %Find indexes of mesh vertices that describe the outline
        outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),region1coef);
        
        %Here we apply a rule to find a common coordinate among the samples
        %E.g. here we look for coordinates in each limb with the smallest y
        
        if ~isempty(outline1) %If an outline is found
            [~,I] = min(composite.vertices(organSel(temp(region1(outline1))),2));
            outline1 = circshift(outline1,size(outline1,1)+1-I); %Rotate coorinate indices
            outline1 = [outline1;outline1(1)]; %Complete the circle
            
            %Construct an outline from our boundary made up of 1000 coordinates
            [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(organSel(temp(region1(outline1))),1),composite.vertices(organSel(temp(region1(outline1))),2));
        
        else %If an outline is not found, use the outline from the previous layer
            trueOutline(1:1000,1,j) = outlineHold(1:1000,1,j);
            trueOutline(1:1000,2,j) = outlineHold(1:1000,2,j);
        end
        
        %Perform the same operations for the other region
        outline2 = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),region2coef);
        
        if ~isempty(outline2)
            %Can use a different rule for the other region
            %E.g. identify the point that is furthest from the origin
            [~,I] = max(sum(composite.vertices(organSel(temp(region2(outline2))),1:2).^2,2));
            outline2 = circshift(outline2,size(outline2,1)+1-I);
            outline2 = [outline2;outline2(1)];
            [trueOutline(1001:2000,1,j),trueOutline(1001:2000,2,j)] = evenOut(composite.vertices(organSel(temp(region2(outline2))),1),composite.vertices(organSel(temp(region2(outline2))),2));
        else
            trueOutline(1001:2000,1,j) = outlineHold(1001:2000,1,j);
            trueOutline(1001:2000,2,j) = outlineHold(1001:2000,2,j);
        end
        
    end
    
    %Ouline for the slice is average of the outlines of each sample
    sliceOutline = nanmean(trueOutline,3);
    
    %Create figure
    f = figure('Color',[0 0 0]);
    axes1 = axes('Parent',f);
    %Plot ouline for each region
    hold on
    p1 = plot(sliceOutline(1:1000,1),sliceOutline(1:1000,2),'Color','white','LineWidth',2);
    p2 = plot(sliceOutline(1001:2000,1),sliceOutline(1001:2000,2),'Color','white','LineWidth',2);
    %Rescale based on whole organ
    xlim([min(composite.vertices(:,1)) 0.95*max(composite.vertices(:,1))])
    ylim([min(composite.vertices(:,2)) max(composite.vertices(:,2))])
    %White lines on black background
    set(f,'Color','black')
    set(axes1,'color','black')
    f.InvertHardcopy = 'off';
    
    %Save as a new image stack
    saveas(f,['testSlice',num2str(i+99),'.tiff']);
%         delete(p1);
%         delete(p2);
    close(f)
end

