%This will be our workbook for the sclice maker. The process is as follows:

% %Load in all of the overlayed meshes of the stage.
% foldername = 'pre2';
% mkdir ['\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\stl\',foldername] ['Slices']
% listing = dir(['\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\stl\',foldername]);
foldername = 'pre3';
listing = dir(['\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\stl\',foldername]);
%Create composite
% composite.vertices = [];
% composite.faces = [];
% temp.vertices = [];
% temp.faces = [];
% templist = {listing.name};
% for i = 3:size(templist,2)-2
%     [temp.vertices,temp.faces] = stlread(templist{i});
%     composite.vertices = cat(3,composite.vertices,temp.vertices);
%     composite.faces = cat(3,composite.faces,temp.faces);
% end

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
    %compositeIndex represents the index that separates the list of
    %vertices into their different segments.
end




%Break down into different depths, say, 50
%!!!!For arguments sake, lets say they've been cropped to be of an
%appropriate length!!!! Either we add a step before here to crop them, or
%we crop them in the other software.
% sliceDepths = [min(composite.vertices(:,3)),max(composite.vertices(:,3))];
sliceDepths = [150,max(composite.vertices(:,3))];
sliceRes = diff(sliceDepths)/99; % Actual slice will vary. We want isotropic sampling, so once we work out how to find the pixel resolution in the plotting function, we'll do slices from the top to the bottom in a step size/resolution of what ever will produce isotropy.
%Scaling selectivity, shaft ones need to be thicker on account of the
%sparser triangulation, whilst the latter want to be thinner
sliceResScale = [1.7*ones(1,50),2.2*ones(1,50)];
% sliceDepths = [sliceDepths(2):-sliceRes:sliceDepths(1)];
sliceDepths = [sliceDepths(1):sliceRes:sliceDepths(2)];
trueOutline = NaN(2000,2,size(composite.vindex,2)-1);
for i = 61:68%1:size(sliceDepths,2)
    
    for j = 1:size(composite.vindex,2)-1
        region1 = [];
        region2 = [];
        organSel = [composite.vindex(j)+1:composite.vindex(j+1)];
        temp = find(abs(composite.vertices(organSel,3)-sliceDepths(i))<(sliceRes/sliceResScale(i)));
        %         temp = find(ismembertol(composite.vertices(:,3,j),sliceDepths(i),(sliceRes)/20));
        if isempty(temp)
            continue
        end
        %         scatter(composite.vertices(thing(temp),1),composite.vertices(thing(temp),2))
        %         plot(composite.vertices(thing(boundary(composite.vertices(thing(temp),:))),1),composite.vertices(thing(boundary(composite.vertices(thing(temp),:))),2));
        %         %Region separation
        %         [countX,edgesX] = histcounts(composite.vertices(thing(temp),1));
        %         [countY,edgesY] = histcounts(composite.vertices(thing(temp),2));
        %         %Find maxima in the counts
        %         xMax = find(diff(countX)<0);
        %         yMax = find(diff(countY)<0);
        %         [~,I] = sort(countX(xMax)); %We want the maxima that contain the largest number
        %         xMax = [xMax(I(1)),xMax(I(2))]; %largest contributes to medial, 2nd to the lateral, at least for the test case.
        %         [~,I] = sort(countY(yMax)); %We want the maxima that contain the largest number
        %         yMax = [yMax(I(1)),yMax(I(2))]; %largest contributes to medial, 2nd to the lateral, at least for the test case.
        %         if size(xMax,2)~=1 || size(yMax,2)~=1 %Two distinct regions
        %             %Separate the data
        %             if size(yMax,2)==1
        %                 %indices that correspond to the first region
        %                 %Find the centre of the maximum
        %                 xMean1 = edgesX(xMax(1)) + 0.5*diff(edgesX(1:2));
        %                 yMean1 = edgesY(yMax(1)) + 0.5*diff(edgesY(1:2));
        %
        %                 xMean2 = edgesX(xMax(2)) + 0.5*diff(edgesX(1:2));
        %                 yMean2 = yMean1;
        %
        %                 region1 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ));
        %                 region2 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ));
        %             elseif size(xMax,2)==1
        %                 xMean1 = edgesX(xMax(1)) + 0.5*diff(edgesX(1:2));
        %                 yMean1 = edgesY(yMax(1)) + 0.5*diff(edgesY(1:2));
        %
        %                 xMean2 = xMean1;
        %                 yMean2 = edgesY(yMax(2)) + 0.5*diff(edgesY(1:2));
        %
        %                 region1 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ));
        %                 region2 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ));
        %             else
        %                 xMean1 = edgesX(xMax(1)) + 0.5*diff(edgesX(1:2));
        %                 yMean1 = edgesY(yMax(1)) + 0.5*diff(edgesY(1:2));
        %
        %                 xMean2 = edgesX(xMax(2)) + 0.5*diff(edgesX(1:2));
        %                 yMean2 = edgesY(yMax(2)) + 0.5*diff(edgesY(1:2));
        %
        %                 region1 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ));
        %                 region2 = find((sqrt( ( composite.vertices(thing(temp),1)-xMean2 ).^2 + ( composite.vertices(thing(temp),2)-yMean2 ).^2 ))<(sqrt( ( composite.vertices(thing(temp),1))-xMean1 ).^2 + ( composite.vertices(thing(temp),2)-yMean1 ).^2 ));
        %             end
        %
        %         else
        %             region1 = temp+composite.vindex(j)+1;
        %         end
        region1 = find(composite.vertices(organSel(temp),1)<1655);
        region2 = find(composite.vertices(organSel(temp),1)>1645);
        %Show individual limbs in this layer and plot oulines found
        figure
        hold on
        scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
        %                 scatter(edgesX(xMax),edgesY(yMax))
        k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
        plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
        k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
        plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
        hold off
        %Conv Hull method
        %         outline1 = convhull(composite.vertices(region1,1:2));
        %         outline1(end) = [];
        %         [~,I] = max(composite.vertices(region1(outline1),1));%max in x
        %Boundary methos
        trueOutline = NaN(2000,2,size(composite.vindex,2)-1);
        
        
        %         change = 1;%I'd say a good starting point to limit x jums at would be 50.
        outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
%         while 1
%             %             'ping'
% %             figure
% %             hold on
% %             scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
% %             %                 scatter(edgesX(xMax),edgesY(yMax))
% %             k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
% %             plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
% %             k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
% %             plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
% %             hold off
%             
%             outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
%             xcoor = composite.vertices(organSel(temp(region1(outline1))),1);
%             xmean = mean(abs(diff(xcoor)));
%             xdiff = diff(xcoor);
% %             xdiffloc = find((abs(xdiff)/xmean)>3);
% %             xdiffloc = find(abs(xdiff)>50);
% %             xdiffloc = [xdiffloc,xdiffloc+1];
%             [~,xdiffloc] = max(abs(xdiff));
%             if abs(xdiff(xdiffloc))<50
%                 break
%             end
%             if isempty(xdiffloc)
%                 break
%             end
%             %             temp(region1(xdiffloc)) = [];
% %             region1(xdiffloc) = [];
%             xvals = [composite.vertices(organSel(temp(region1(outline1(xdiffloc)))),1),composite.vertices(organSel(temp(region1(outline1(xdiffloc+1)))),1)];
%             correction = xvals(2)>xvals(1);
%             %cdiffloc tells we the pair which is showing the largest jump.
%             %From that pair, we need to remove the one that is the most
%             %right. so look at the indexs and index plus one. if second is
%             %larger, take xdiffloc and add 1. then remove.
%             region1(outline1(xdiffloc+correction)) = [];
%         end
        
        
        %         outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
        if ~isempty(outline1)
            [~,I] = min(composite.vertices(organSel(temp(region1(outline1))),1));
            outline1 = circshift(outline1,size(outline1,1)+1-I);
            outline1 = [outline1;outline1(1)];
            [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(organSel(temp(region1(outline1))),1),composite.vertices(organSel(temp(region1(outline1))),2));
        end
        %Need to "rotate" outlineI till the most x is the first element
        outline2 = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);

%         while 1
% 
% 
%             outline2 = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
%             xcoor = composite.vertices(organSel(temp(region2(outline2))),1);
%             xmean = mean(abs(diff(xcoor)));
%             xdiff = diff(xcoor);
%             [~,xdiffloc] = max(abs(xdiff));
%             if abs(xdiff(xdiffloc))<40
%                 break
%             end
%             if isempty(xdiffloc)
%                 break
%             end
%             xvals = [composite.vertices(organSel(temp(region2(outline2(xdiffloc)))),1),composite.vertices(organSel(temp(region2(outline2(xdiffloc+1)))),1)];
%             correction = xvals(2)>xvals(1);
%             region2(outline2(xdiffloc+correction)) = [];
%         end
        if ~isempty(outline2)
            [~,I] = max(composite.vertices(organSel(temp(region2(outline2))),2));
            outline2 = circshift(outline2,size(outline2,1)+1-I);
            outline2 = [outline2;outline2(1)];
            [trueOutline(1001:2000,1,j),trueOutline(1001:2000,2,j)] = evenOut(composite.vertices(organSel(temp(region2(outline2))),1),composite.vertices(organSel(temp(region2(outline2))),2));
        end
%         figure
%         hold on
%         scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
%         %                 scatter(edgesX(xMax),edgesY(yMax))
%         k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
%         plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
%         k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
%         plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
%         hold off
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
        %         for j = 1:size(composite.index,2)-1
        %             [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(region1(outline1),1),composite.vertices(region1(outline1),2));
        %             [trueOutline(1001:2000,1,j),trueOutline(1001:2000,2,j)] = evenOut(composite.vertices(region2(outline2),1),composite.vertices(region2(outline2),2));
%         [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(organSel(temp(region1(outline1))),1),composite.vertices(organSel(temp(region1(outline1))),2));
%         [trueOutline(1001:2000,1,j),trueOutline(1001:2000,2,j)] = evenOut(composite.vertices(organSel(temp(region2(outline2))),1),composite.vertices(organSel(temp(region2(outline2))),2));
        %         end
        %         if ~isempty(region2)
        %             [trueOutline(1001:end,1,j),trueOutline(1001:end,2,j)] = evenOut(composite.vertices(region2(outline1),1,j),composite.vertices(region2(outline1),2,j));
        %         end
        %                 for k = 1:size(trueOutline,1)
        %
        %                 end
        
    end
    
    %     figure
    %     xlim([min(composite.vertices(:,1)) max(composite.vertices(:,1))])
    %     ylim([min(composite.vertices(:,2)) max(composite.vertices(:,2))])
    %     hold on
    %     for k = 1:size(trueOutline,3)
    %     plot(trueOutline(1:1000,1,k),trueOutline(1:1000,2,k))
    %     end
    %     hold off
    sliceOutline = nanmean(trueOutline,3);
    %     if i==1
    f = figure('Color',[0 0 0]);
    axes1 = axes('Parent',f);
    hold on
    p1 = plot(sliceOutline(1:1000,1),sliceOutline(1:1000,2),'Color','white','LineWidth',2);
    p2 = plot(sliceOutline(1001:2000,1),sliceOutline(1001:2000,2),'Color','white','LineWidth',2);
    xlim([min(composite.vertices(:,1)) max(composite.vertices(:,1))])
    ylim([min(composite.vertices(:,2)) max(composite.vertices(:,2))])
    set(f,'Color','black')
    set(axes1,'color','black')
    %         xLimits = get(f,'XLim');
    %         yLimits = get(f,'YLim');
    %     else
    %         set(f,'XLim',xLimits);
    %         set(f,'YLim',yLimits);
    %     else
    %         p1 = plot(sliceOutline(1:1000,1),sliceOutline(1:1000,2),'Color','white','LineWidth',2);
    %         p2 = plot(sliceOutline(1001:2000,1),sliceOutline(1001:2000,2),'Color','white','LineWidth',2);
    %     end
    %     imwrite()
    f.InvertHardcopy = 'off';
    saveas(f,['testSlice',num2str(i+99),'.tiff']);
    %     delete(p1);
    %     delete(p2);
end
%close(f)

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