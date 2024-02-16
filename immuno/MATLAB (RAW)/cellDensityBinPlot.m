%Ok this is the program that takes place after we've autoiatically
%registered some data and placed them into a struct. Now we just need to
%create a mesh, assign points to each location in the mesh based on
%nearest. We can do that by subtracting the lattice coordinate from all of
%the data, then findeing points that have an x and y value less than half
%the resolution. once each data point has a lattice point associated with
%it, we can create a surf with number of data points as the color.

meshInt = 25;

%Now we just need to create a mesh, 
% 
% [tempX,tempY] = deal(cellPosStruct(1).data(:,1),cellPosStruct(1).data(:,2));
% meshBounds = [min(tempX)-10,max(tempX)+10, ...
%                 min(tempY)-10,max(tempY)+10];
% [xIm,yIm] = meshgrid([meshBounds(1):25:meshBounds(2)],[meshBounds(3):25:meshBounds(4)]);          


% We can actually combine the data since we don't care which specimen it
%came from
tempData = [];
for i = 1:size(cellPosStruct,2)
tempData = [tempData;cellPosStruct(i).data];
end
meshBounds = [min(tempData(:,1))-10,max(tempData(:,1))+10, ...
                 min(tempData(:,2))-10,max(tempData(:,2))+10];
[xIm,yIm] = meshgrid([meshBounds(1):meshInt:meshBounds(2)],[meshBounds(3):meshInt:meshBounds(4)]);
plotData = zeros(size(xIm));
%assign points to each location in the mesh based on nearest. 

for i = 1:size(xIm,2)
    for j = 1:size(xIm,1)
        %We can do that by subtracting the lattice coordinate from all of the data,
        distances = [tempData(:,1) - ones(size(tempData,1),1)*xIm(1,i),...
                     tempData(:,2) - ones(size(tempData,1),1)*yIm(j,1)];
        %then finding points that have an x and y value less than half the resolution.
        check = numel(find(abs(distances(:,1))<(meshInt/2) & abs(distances(:,2))<(meshInt/2)));
        if ~isempty(check)
            plotData(j,i) = check/size(cellPosStruct,2); %Normalised per limb to allow cross sample comparison
        end
    end
end
%once each data point has a lattice point associated with it, we can create a surf with number of data points as the color.
figure
surf(xIm,yIm,zeros(size(xIm)),plotData,'EdgeColor','interp','FaceColor','interp');
colormap turbo
xlim([meshBounds(2)-800 meshBounds(2)])
ylim([meshBounds(4)-800 meshBounds(4)])
caxis([0 10.8])


%This method has a problem with edges, can reduce by making the lattice
%finer and interpolating.



%new idea: bin data points into squares.

%Use polyarea to outline the 