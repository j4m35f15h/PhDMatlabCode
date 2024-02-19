%This will be our workbook for the sclice maker. The process is as follows:

%Load in all of the overlayed meshes of the stage.
foldername = 'temp';
mkdir foldername [foldername,'Slices']
listing = dir(foldername);
composite.vertices = [];
composite.faces = [];
for i = 3:size(listing.name,1)
    [temp.vertices,temp.faces] = stlread(listing.name(i));
    composite.vertices = cat(3,composite.vertices,temp.vertices);
    composite.faces = cat(3,composite.faces,temp.faces);
end
%Break down into different depths, say, 50
%!!!!For arguments sake, lets say they've been cropped to be of an
%appropriate length!!!! Either we add a step before here to crop them, or
%we crop them in the other software.
sliceDepths = [min(min(composite.vertices(:,3,:)),[],3),max(max(composite.vertices(:,3,:)),[],3)];
sliceRes = diff(sliceDepths)/49;
% sliceDepths = [sliceDepths(2):-sliceRes:sliceDepths(1)];
sliceDepths = [sliceDepths(1):sliceRes:sliceDepths(2)];
trueOutline = NaN(2000,3,size(composite.vertices,3));
for i = 1:size(sliceDepths,2)
    for j = 1:size(composite.vertices,3)
        region2 = [];
        temp = find(abs(composite.vertices(:,3,j)-sliceDepths(i))<(sliceRes/2));
%         temp = find(ismembertol(composite.vertices(:,3,j),sliceDepths(i),(sliceRes)/20));
        if isempty(temp)
            continue
        end
%         %Region separation
%         [countX,edgesX] = histcounts(composite.vertices(temp,1,j));
%         [countY,edgesY] = histcounts(composite.vertices(temp,2,j));
%         %Find maxima in the counts
%         xMax = find(diff(countX)<0);
%         yMax = find(diff(countY)<0);
%         if size(xMax,2)~=1 || size(yMax,2)~=1 %Two distinct regions
%             %Separate the data
%             if size(xMax,2)~=1
%                 %indices that correspond to the first region
%                 %Find the centre of the maximum
%                 xMean1 = edgesX(xMax(1)) + 0.5*diff(edgesX(1:2));
%                 yMean1 = edgesY(yMax(1)) + 0.5*diff(edgesY(1:2));
%                 
%                 xMean2 = edgesX(xMax(2)) + 0.5*diff(edgesX(1:2));
%                 yMean2 = yMean1;
%                 
%                 region1 = find((sqrt( ( composite.vertices(temp,1,j)-xMean1 ).^2 + ( composite.vertices(temp,2,j)-yMean1 ).^2 ))<(sqrt( ( composite.vertices(temp,1,j)-xMean2 ).^2 + ( composite.vertices(temp,2,j)-yMean2 ).^2 )));
%                 region2 = find((sqrt( ( composite.vertices(temp,1,j)-xMean2 ).^2 + ( composite.vertices(temp,2,j)-yMean2 ).^2 ))<(sqrt( ( composite.vertices(temp,1,j)-xMean1 ).^2 + ( composite.vertices(temp,2,j)-yMean1 ).^2 )));
%             else
%                 xMean1 = edgesX(xMax(1)) + 0.5*diff(edgesX(1:2));
%                 yMean1 = edgesY(yMax(1)) + 0.5*diff(edgesY(1:2));
%                 
%                 xMean2 = xMean1;
%                 yMean2 = edgesY(yMax(2)) + 0.5*diff(edgesY(1:2));
%                 
%                 region1 = find((sqrt( ( composite.vertices(temp,1,j)-xMean1 ).^2 + ( composite.vertices(temp,2,j)-yMean1 ).^2 ))<(sqrt( ( composite.vertices(temp,1,j)-xMean2 ).^2 + ( composite.vertices(temp,2,j)-yMean2 ).^2 )));
%                 region2 = find((sqrt( ( composite.vertices(temp,1,j)-xMean2 ).^2 + ( composite.vertices(temp,2,j)-yMean2 ).^2 ))<(sqrt( ( composite.vertices(temp,1,j)-xMean1 ).^2 + ( composite.vertices(temp,2,j)-yMean1 ).^2 )));
%             end
%             
%         else
            region1 = temp;
%         end
        outline1 = convhull(composite.vertices(region1,1:2,j));
%         outline1(end) = [];
%         [~,I] = max(composite.vertices(outline1,1,j));%max in x
        
        %Need to "rotate" outlineI till the most x is the first element
%         outline1 = circshift(outline1,size(outline1,1)+1-I);
%         outline1 = [outline1;outline1(1)];
%         if ~isempty(region2)
%             outline2 = convhull(composite.vertices(region2,1:2,j));
% %             outline2(end) = [];
% %             [~,I] = max(composite.vertices(outline2,1,j));%max in x
% %             
% %             %Need to "rotate" outlineI till the most z is the first element
% %             outline2 = circshift(outline2,size(outline2,1)+1-I);
% %             outline2 = [outline2;outline2(1)];
%         end
        
        %Then separate the x and y coordinates out
        %pass this to the existing script
        [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(region1(outline1),1,j),composite.vertices(region1(outline1),2,j));
%         if ~isempty(region2)
%             [trueOutline(1001:end,1,j),trueOutline(1001:end,2,j)] = evenOut(composite.vertices(region2(outline1),1,j),composite.vertices(region2(outline1),2,j));
%         end
        %                 for k = 1:size(trueOutline,1)
        %
        %                 end
        
    end
    sliceOutline = nanmean(trueOutline,3);
    if i==1
        f = figure('Color',[0 0 0]);
        axes1 = axes('Parent',f);
        hold on
        p = plot(sliceOutline(:,1),sliceOutline(:,2),'Color','white','LineWidth',2);
        set(f,'Color','black')
        set(axes1,'color','black')
%         xLimits = get(f,'XLim');
%         yLimits = get(f,'YLim');
%     else
%         set(f,'XLim',xLimits);
%         set(f,'YLim',yLimits);
    else
        p = plot(sliceOutline(:,1),sliceOutline(:,2),'Color','white','LineWidth',2);
    end
    %     imwrite()
    f.InvertHardcopy = 'off';
    saveas(f,['testSlice',num2str(i),'.tiff']);
    delete(p); 
end
close(f)

%find some vertices to make a convex hull out of.

%Use the function we made earlier to break that hull down into let's say
%100 equally spaced points, starting from lets say the highest z

%By index, set the ideal point to be the average location of that index.

%Create a plot with a white line color, remove the axis, make the
%background black, and save it using ideal01 etc.

%Repeat till complete


%Extension:
%Make it into a function so it can take a file name and open all stls
%inside.
%Make it create a subfolder in the opened file for it to store the stuff