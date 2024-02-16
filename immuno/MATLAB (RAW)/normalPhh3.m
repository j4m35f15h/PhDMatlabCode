% %this is a slightly altered version of the cell density heat map. Instead,
% %we'll plot the normal cell density at 0 with a greyscale surf at 0, then
% %at plus minus arbitrary, we'll NaN surf the Phh3 data.
% 
% meshInt = 25;
% 
% %Now we just need to create a mesh, 
% % 
% % [tempX,tempY] = deal(cellPosStruct(1).data(:,1),cellPosStruct(1).data(:,2));
% % meshBounds = [min(tempX)-10,max(tempX)+10, ...
% %                 min(tempY)-10,max(tempY)+10];
% % [xIm,yIm] = meshgrid([meshBounds(1):25:meshBounds(2)],[meshBounds(3):25:meshBounds(4)]);          
% 
% 
% % We can actually combine the data since we don't care which specimen it
% %came from
% tempData = [];
% tempDataPhh3 = [];
% for i = 1:size(cellPosStruct,2)
% tempData = [tempData;cellPosStruct(i).data];
% tempDataPhh3 = [tempDataPhh3;cellPosStruct(i).phh3];
% end
% meshBounds = [min(tempData(:,1))-10,max(tempData(:,1))+10, ...
%                  min(tempData(:,2))-10,max(tempData(:,2))+10];
% [xIm,yIm] = meshgrid([meshBounds(1):meshInt:meshBounds(2)],[meshBounds(3):meshInt:meshBounds(4)]);
% plotData = zeros(size(xIm));
% plotDataPhh3 = NaN(size(xIm));
% %assign points to each location in the mesh based on nearest. 
% % 
% % for i = 1:size(xIm,2)
% %     for j = 1:size(xIm,1)
% %         %We can do that by subtracting the lattice coordinate from all of the data,
% %         distances = [tempData(:,1) - ones(size(tempData,1),1)*xIm(1,i),...
% %                      tempData(:,2) - ones(size(tempData,1),1)*yIm(j,1)];
% %         %then finding points that have an x and y value less than half the resolution.
% %         check = numel(find(abs(distances(:,1))<(meshInt/2) & abs(distances(:,2))<(meshInt/2)));
% %         if ~isempty(check)
% %             plotData(j,i) = check/size(cellPosStruct,2); %Normalised per limb to allow cross sample comparison
% %         end
% %     end
% % end
% 
% for i = 1:size(xIm,2)
%     for j = 1:size(xIm,1)
%         %We can do that by subtracting the lattice coordinate from all of the data,
%         distances = [tempData(:,1) - ones(size(tempData,1),1)*xIm(1,i),...
%                      tempData(:,2) - ones(size(tempData,1),1)*yIm(j,1)];
%         %then finding points that have an x and y value less than half the resolution.
%         
%         check = [];
%         index = 1;
%         for k = 1:size(cellPosStruct,2)
%             check = [check,numel(find(abs(distances(index:index + size(cellPosStruct(k).data,1)-1,1))<(meshInt/2) & abs(distances(index:index + size(cellPosStruct(k).data,1)-1,2))<(meshInt/2)))];
%             index = index + size(cellPosStruct(k).data,1);
%         end
%         if nnz(check)
%             plotData(j,i) = sum(check)/nnz(check);
%         end
%     end
% end
% 
% for i = 1:size(xIm,2)
%     for j = 1:size(xIm,1)
%         %We can do that by subtracting the lattice coordinate from all of the data,
%         distances2 = [tempDataPhh3(:,1) - ones(size(tempDataPhh3,1),1)*xIm(1,i),...
%                         tempDataPhh3(:,2) - ones(size(tempDataPhh3,1),1)*yIm(j,1)];
%         %then finding points that have an x and y value less than half the resolution.
%         check = numel(find(abs(distances2(:,1))<(meshInt/2) & abs(distances2(:,2))<(meshInt/2)));
%         if ~isempty(check)
%             plotDataPhh3(j,i) = check/size(cellPosStruct,2); %Normalised per limb to allow cross sample comparison
%         end      
%     end
% end
% 
% %once each data point has a lattice point associated with it, we can create a surf with number of data points as the color.
% zVals = ones(size(xIm));
% % zVals(plotDataPhh3 == 0) = deal(NaN);
% % tempIndex = find(zVals==1);
% % [zVals(tempIndex+1),zVals(tempIndex-1),zVals(tempIndex+size(zVals(2))),zVals(tempIndex-size(zVals(2)))] = deal(1);
% 
% % ax1 = axes;
% % surf(ax1,xIm,yIm,zeros(size(xIm)),plotData,'EdgeColor','interp','FaceColor','interp');
% % view(2)
% % ax2 = axes;
% % surf(ax2,xIm,yIm,zVals,plotDataPhh3,'EdgeColor','interp','FaceColor','interp');
% % view(3)
% % ax3 = axes;
% % surf(ax3,xIm,yIm,-1*zVals,plotDataPhh3,'EdgeColor','interp','FaceColor','interp');
% % %%Link them together
% % linkaxes([ax1,ax2,ax3])
% % %%Hide the top axes
% % ax2.Visible = 'off';
% % ax2.XTick = [];
% % ax2.YTick = [];
% % ax3.Visible = 'off';
% % ax3.XTick = [];
% % ax3.YTick = [];
% % %%Give each one its own colormap
% % colormap(ax1,'gray')
% % colormap(ax2,'turbo')
% % colormap(ax3,'turbo')
% %%Then add colorbars and get everything lined up
% % set([ax1,ax2],'Position',[.17 .11 .685 .815]);
% % cb1 = colorbar(ax1,'Position',[.05 .11 .0675 .815]);
% % cb2 = colorbar(ax2,'Position',[.88 .11 .0675 .815]);
% 
% 
% % figure
% % hold on
% % surf(xIm,yIm,zeros(size(xIm)),plotData,'EdgeColor','interp','FaceColor','interp');
% % colormap gray
% % caxis([0 10.8])
% % surf(xIm,yIm,zVals,plotDataPhh3,'EdgeColor','interp','FaceColor','interp');
% % colormap turbo
% % surf(xIm,yIm,-1*zVals,plotDataPhh3,'EdgeColor','interp','FaceColor','interp');
% % colormap turbo
% % hold off
% % xlim([meshBounds(2)-800 meshBounds(2)])
% % ylim([meshBounds(4)-800 meshBounds(4)])
% 
% figure
% hold on
% surf(xIm,yIm,zeros(size(xIm)),plotData,'EdgeColor','interp','FaceColor','interp');
% colormap turbo
% caxis([0 10.8])
% scatter3(xIm(find(plotDataPhh3)),yIm(find(plotDataPhh3)),ones(size(find(plotDataPhh3))),'MarkerEdgeColor','black','LineWidth',1)
% hold off
% xlim([meshBounds(2)-800 meshBounds(2)])
% ylim([meshBounds(4)-800 meshBounds(4)])

%Now we want take this data and make something rougher
%Break down original into bin size of 150
meshInt = 110;
[xIm,yIm] = meshgrid([meshBounds(1):meshInt:meshBounds(2)+meshInt],[meshBounds(3):meshInt:meshBounds(4)+meshInt]);
tempData = [];
tempDataPhh3 = [];
for i = 1:size(cellPosStruct,2)
tempData = [tempData;cellPosStruct(i).data];
tempDataPhh3 = [tempDataPhh3;cellPosStruct(i).phh3];
end
meshBounds = [min(tempData(:,1))-10,max(tempData(:,1))+10, ...
                min(tempData(:,2))-10,max(tempData(:,2))+10];
plotData = zeros(size(xIm));
plotDataPhh3 = NaN(size(xIm));

%Find average cell density in these new bins
for i = 1:size(xIm,2)
    for j = 1:size(xIm,1)
        %We can do that by subtracting the lattice coordinate from all of the data,
        distances = [tempData(:,1) - ones(size(tempData,1),1)*xIm(1,i),...
                     tempData(:,2) - ones(size(tempData,1),1)*yIm(j,1)];
        %then finding points that have an x and y value less than half the resolution.
        
        check = [];
        index = 1;
        for k = 1:size(cellPosStruct,2)
            check = [check,numel(find(abs(distances(index:index + size(cellPosStruct(k).data,1)-1,1))<(meshInt/2) & abs(distances(index:index + size(cellPosStruct(k).data,1)-1,2))<(meshInt/2)))];
            index = index + size(cellPosStruct(k).data,1);
        end
        if nnz(check)
            plotData(j,i) = sum(check)/nnz(check);
        end
    end
end

for i = 1:size(xIm,2)
    for j = 1:size(xIm,1)
        %We can do that by subtracting the lattice coordinate from all of the data,
        distances2 = [tempDataPhh3(:,1) - ones(size(tempDataPhh3,1),1)*xIm(1,i),...
                        tempDataPhh3(:,2) - ones(size(tempDataPhh3,1),1)*yIm(j,1)];
        %then finding points that have an x and y value less than half the resolution.
        check = numel(find(abs(distances2(:,1))<(meshInt/2) & abs(distances2(:,2))<(meshInt/2)));
        if ~isempty(check)
            plotDataPhh3(j,i) = check/size(cellPosStruct,2); %Normalised per limb to allow cross sample comparison
        end      
    end
end
%Find the sum of normalised cell density in these bind.
%Normalise by the average cel density
plotData = plotDataPhh3./plotData;
plotData(isnan(plotData)) = 0;
%Plot grid with outline overlay?
figure
% surf(xIm,yIm,zeros(size(xIm)),plotData,'EdgeColor','interp','FaceColor','interp');
surf(xIm,yIm,zeros(size(xIm)),plotData);
colormap turbo
caxis([0 0.1])
hold on
k = boundary(tempData);
% plot3(tempData(k,1)-meshInt/2,tempData(k,2)-meshInt/2,ones(size(tempData(k,1))),'k')
plot3(tempData(k,1)+meshInt/4,tempData(k,2),ones(size(tempData(k,1))),'k')
hold off
xlim([meshBounds(2)-800 meshBounds(2)])
ylim([meshBounds(4)-800 meshBounds(4)])