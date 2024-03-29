load('rudimentDrawn.mat')
rudimentX = rudimentX';
rudimentY = rudimentY';
rudimentX = [rudimentX,rudimentX(1)];
rudimentX = rudimentX + 0.22;
rudimentY = [rudimentY,rudimentY(1)];
% rudimentX = [0 1 1 2 2 3 3 4 4 8];
% rudimentY = [0 0 1 1 2 2 3 3 4 8];
relMarker = cumsum(sqrt(diff(rudimentX).^2 + diff(rudimentY).^2));
distanceTotal = relMarker(end);
relMarker = relMarker/distanceTotal;
relMarker = [0,relMarker]; 
NSeg = 2000;
segmentPosition = 0:1/NSeg:1;
%segmentPositions = segmentPositions*distanceTotal;
relPosition = zeros(size(segmentPosition));
for i = 1:size(segmentPosition,2)
    for j = 1:size(relMarker,2)
        if segmentPosition(1,i) < relMarker(1,j)
            relPosition(1,i) = j-1;
            break;
        end
    end
end
relPosition(1,end) = relPosition(1,end-1);
%Need to subtract the relPosition relative marker from the segmentPosition,
%then find the difference in relPosition with the next marker. The
%coordinate is then the relPosition + the subtraction*the 
segmentX = zeros(size(segmentPosition));
segmentY = zeros(size(segmentPosition));
for i = 1 : size(segmentPosition,2)
    if relMarker(relPosition(1,i))+1 > size(rudimentX,2)
        segmentX(i) = rudimentX(relMarker(1,relPosition(1,i)));
        segmentY(i) = rudimentY(relMarker(1,relPosition(1,i)));
        break;
    end
    relDiff = (segmentPosition(1,i) - relMarker(1,relPosition(1,i)))/(relMarker(1,relPosition(1,i)+1) - relMarker(1,relPosition(1,i)));
    segmentX(i) = rudimentX(1,relPosition(1,i)) + relDiff*(rudimentX(1,relPosition(1,i)+1)-rudimentX(1,relPosition(1,i)));
    segmentY(i) = rudimentY(1,relPosition(1,i)) + relDiff*(rudimentY(1,relPosition(1,i)+1)-rudimentY(1,relPosition(1,i)));
end
clear relMarker relPosition segmentPosition relDiff NSeg distanceTotal rudimentX rudimentY