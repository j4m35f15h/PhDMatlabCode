function [newXCoord,newYCoord] = evenOut(xCoord,yCoord)

%Variable which controls the number of coordinates in the upsampled line

NSeg = 1000;

%------------------------------------------------------------------

%Converts data to row vector if necessary

if size(xCoord,2) == 1
    xCoord = xCoord';
end
if size(yCoord,2) == 1
    yCoord = yCoord';
end

%------------------------------------------------------------------

%Create the framework to assign the coordinates. First the input coordinates as well as the potential
%new coordinates are converted into relative positions; proportions along the original path with 
%values between 0 and 1

relMarker = cumsum(sqrt(diff(xCoord).^2 + diff(yCoord).^2));
distanceTotal = relMarker(end);
relMarker = relMarker/distanceTotal;
relMarker = [0,relMarker]; %Path starts from zero


%Create a variable relPositions that stores between which of the original coordinates the new point lies between
segmentPosition = 0:1/(NSeg-1):1;
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

%Next subtract the "relPosition" index relative marker from the segmentPosition,
%then find the difference in relPosition with the next marker. The new
%coordinate is then the relPosition + the subtraction*the difference

newXCoord = zeros(size(segmentPosition));
newYCoord = zeros(size(segmentPosition));
for i = 1 : size(segmentPosition,2)
    if relMarker(relPosition(1,i))+1 > size(xCoord,2)
        newXCoord(i) = xCoord(relMarker(1,relPosition(1,i)));
        newYCoord(i) = yCoord(relMarker(1,relPosition(1,i)));
        break;
    end
    relDiff = (segmentPosition(1,i) - relMarker(1,relPosition(1,i)))/(relMarker(1,relPosition(1,i)+1) - relMarker(1,relPosition(1,i)));
    newXCoord(i) = xCoord(1,relPosition(1,i)) + relDiff*(xCoord(1,relPosition(1,i)+1)-xCoord(1,relPosition(1,i)));
    newYCoord(i) = yCoord(1,relPosition(1,i)) + relDiff*(yCoord(1,relPosition(1,i)+1)-yCoord(1,relPosition(1,i)));
end

newXCoord = newXCoord';
newYCoord = newYCoord';


end

