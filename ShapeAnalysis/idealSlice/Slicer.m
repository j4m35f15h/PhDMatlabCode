%This will be our workbook for the sclice maker. The process is as follows:

% %Load in all of the overlayed meshes of the stage.
% foldername = 'pre2';
% mkdir ['\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\stl\',foldername] ['Slices']
% listing = dir(['\\icnas4.cc.ic.ac.uk\jem14\Desktop\PhD\matlab scripts\stl\',foldername]);
foldername = 'D2Dyn';
listing = dir(['R:\live\James\septemberExp20\',foldername]);
addpath(['R:\live\James\septemberExp20\',foldername]);
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
for i =6:9%6:size(templist,2)-1
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
sliceDepths = [min(composite.vertices(:,3)),max(composite.vertices(:,3))];
sliceRes = diff(sliceDepths)/99; % Actual slice will vary. We want isotropic sampling, so once we work out how to find the pixel resolution in the plotting function, we'll do slices from the top to the bottom in a step size/resolution of what ever will produce isotropy.
%Scaling selectivity, shaft ones need to be thicker on account of the
%sparser triangulation, whilst the latter want to be thinner
sliceResScale = [1.4*ones(1,50),1*ones(1,50)];
% sliceDepths = [sliceDepths(2):-sliceRes:sliceDepths(1)];
sliceDepths = [sliceDepths(1):sliceRes:sliceDepths(2)];
trueOutline = NaN(2000,2,size(composite.vindex,2)-1);
for i = 1:size(sliceDepths,2)
    outlineHold = trueOutline;
    trueOutline = NaN(2000,2,size(composite.vindex,2)-1);
    for j = 1:size(composite.vindex,2)-1
        region1 = [];
        region2 = [];
        organSel = [composite.vindex(j)+1:composite.vindex(j+1)];
        temp = find(abs(composite.vertices(organSel,3)-sliceDepths(i))<(sliceRes/sliceResScale(i)));
        %         temp = find(ismembertol(composite.vertices(:,3,j),sliceDepths(i),(sliceRes)/20));
        if isempty(temp)
            continue
        end
        if size(temp,1)<60
            continue
        end
        if j == 1
            region1 = find(composite.vertices(organSel(temp),1)<530);
            region2 = find(composite.vertices(organSel(temp),1)>520);
        elseif j==2
            region1 = find(composite.vertices(organSel(temp),1)<545);
            region2 = find(composite.vertices(organSel(temp),1)>535);
        elseif j==3
            region1 = find(composite.vertices(organSel(temp),1)<540);
            region2 = find(composite.vertices(organSel(temp),1)>530);
        else
            region1 = find(composite.vertices(organSel(temp),1)<545);
            region2 = find(composite.vertices(organSel(temp),1)>535);
        end

%         Show individual limbs in this layer and plot oulines found
%                 figure
%                 hold on
%                 scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
%         %                         scatter(edgesX(xMax),edgesY(yMax))
%                 k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.6);
%                 plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
%                 k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.4);
%                 plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
%                 hold off
        %Conv Hull method
        %         outline1 = convhull(composite.vertices(region1,1:2));
        %         outline1(end) = [];
        %         [~,I] = max(composite.vertices(region1(outline1),1));%max in x
        %Boundary methos
        
        
        
        %         change = 1;%I'd say a good starting point to limit x jums at would be 50.
        %         while 1
        %             %             'ping'
        region1coef = 0.3;
        region2coef = 0.3;
%         figure
%         hold on
%         scatter(composite.vertices(organSel(temp),1),composite.vertices(organSel(temp),2))
%         %                 scatter(edgesX(xMax),edgesY(yMax))
%         k = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),region1coef);
%         plot(composite.vertices(organSel(temp(region1(k))),1),composite.vertices(organSel(temp(region1(k))),2))
%         k = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),region2coef);
%         plot(composite.vertices(organSel(temp(region2(k))),1),composite.vertices(organSel(temp(region2(k))),2))
%         hold off
        %
        outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),region1coef);
        %             xcoor = composite.vertices(organSel(temp(region1(outline1))),1);
        %             xmean = mean(abs(diff(xcoor)));
        %             xdiff = diff(xcoor);
        %             [~,xdiffloc] = max(abs(xdiff));
        %             if abs(xdiff(xdiffloc))<40
        %                 break
        %             end
        %             if isempty(xdiffloc)
        %                 break
        %             end
        %             xvals = [composite.vertices(organSel(temp(region1(outline1(xdiffloc)))),1),composite.vertices(organSel(temp(region1(outline1(xdiffloc+1)))),1)];
        %             correction = xvals(2)>xvals(1);
        %             region1(outline1(xdiffloc+correction)) = [];
        %         end
        
        
        %         outline1 = boundary(composite.vertices(organSel(temp(region1)),1),composite.vertices(organSel(temp(region1)),2),0.2);
        if ~isempty(outline1)
            %             [~,I] = max(sum(composite.vertices(organSel(temp(region1(outline1))),1:2).^2,2));
            [~,I] = min(composite.vertices(organSel(temp(region1(outline1))),2));
            outline1 = circshift(outline1,size(outline1,1)+1-I);
            outline1 = [outline1;outline1(1)];
            [trueOutline(1:1000,1,j),trueOutline(1:1000,2,j)] = evenOut(composite.vertices(organSel(temp(region1(outline1))),1),composite.vertices(organSel(temp(region1(outline1))),2));
        else
            trueOutline(1:1000,1,j) = outlineHold(1:1000,1,j);
            trueOutline(1:1000,2,j) = outlineHold(1:1000,2,j);
        end
        %Need to "rotate" outlineI till the most x is the first element
        outline2 = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),region2coef);
        
        %         while 1
        %
        %
        %             outline2 = boundary(composite.vertices(organSel(temp(region2)),1),composite.vertices(organSel(temp(region2)),2),0.6);
        %             xcoor = composite.vertices(organSel(temp(region2(outline2))),1);
        %             xmean = mean(abs(diff(xcoor)));
        %             xdiff = diff(xcoor);
        %             [~,xdiffloc] = max(abs(xdiff));
        %             if abs(xdiff(xdiffloc))<60
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
            %             [~,I] = min(composite.vertices(organSel(temp(region2(outline2))),1));
            [~,I] = max(sum(composite.vertices(organSel(temp(region2(outline2))),1:2).^2,2));
            outline2 = circshift(outline2,size(outline2,1)+1-I);
            outline2 = [outline2;outline2(1)];
            [trueOutline(1001:2000,1,j),trueOutline(1001:2000,2,j)] = evenOut(composite.vertices(organSel(temp(region2(outline2))),1),composite.vertices(organSel(temp(region2(outline2))),2));
        else
            trueOutline(1001:2000,1,j) = outlineHold(1001:2000,1,j);
            trueOutline(1001:2000,2,j) = outlineHold(1001:2000,2,j);
        end
        
    end
    
    %Removes any left over incorrect paths.
    %     thinger = diff(trueOutline,1,1);
    %     thinger = sum(sqrt(sum(thinger.^2,2)),1);
    %     avgLength = nanmean(thinger,3);
    %     forRemoval = find(thinger>1.5*avgLength);
    %     trueOutline(1:2000,1:2,forRemoval) = NaN;
    %     thinger = diff(trueOutline,1,1);
    %
    %     summmm = (thinger(:,1,:).^2 + thinger(:,2,:).^2).^0.5;
    %
    %
    %     thinger = thinger./[summmm,summmm];
    %     angles = zeros(2000,1,4);
    %     for m = 1:1999
    %         angles(m,1,:) = acosd(  dot(thinger(m,:,:),circshift(thinger(m,:,:),1),2) );
    %     end
%     for m = 1:size(trueOutline,3)
%         if ~isempty(find(abs(diff(angles(:,:,m)))>100))
%             trueOutline(:,:,m) = NaN(2000,2);
%         end
%     end
%     
    sliceOutline = nanmean(trueOutline,3);
    f = figure('Color',[0 0 0]);
    axes1 = axes('Parent',f);
    hold on
    p1 = plot(sliceOutline(1:1000,1),sliceOutline(1:1000,2),'Color','white','LineWidth',2);
    p2 = plot(sliceOutline(1001:2000,1),sliceOutline(1001:2000,2),'Color','white','LineWidth',2);
    xlim([min(composite.vertices(:,1)) 0.95*max(composite.vertices(:,1))])
    ylim([min(composite.vertices(:,2)) max(composite.vertices(:,2))])
    set(f,'Color','black')
    set(axes1,'color','black')

    f.InvertHardcopy = 'off';
%     saveas(f,['testSlice',num2str(i+99),'.tiff']);
    %     delete(p1);
    %     delete(p2);
%     close(f)
end
%close(f)

%Thing we'll tryu when we get home is to add a third region, which defines
%any bridging points. This has to not include any condyle after they have
%separated.
