function [segmentX,segmentY] = evenOut(rudimentX,rudimentY)


rudimentX = rudimentX';
rudimentY = rudimentY';


relMarker = cumsum(sqrt(diff(rudimentX).^2 + diff(rudimentY).^2));
distanceTotal = relMarker(end);
relMarker = relMarker/distanceTotal;
relMarker = [0,relMarker]; 
NSeg = 1000;
segmentPosition = 0:1/(NSeg-1):1;
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
segmentX = segmentX';
segmentY = segmentY';


end

