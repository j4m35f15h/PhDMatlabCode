%Need to include lattice points in the polygon & lattice points that are
%part of the faces in faceID done on the boundary points.
%Lattice points within the polygon are in the calculation domain. %Lattice
%points within faceId run on the rudiment outline are in the calculation
%domain. The Last groups neighbours are the boundary points.

%Find indexes of vertices within the organ boundary
in = inpolygon(latticeV(1:end/2),latticeV(end/2 + 1:end),segmentX,segmentY);
theta = find(in);

%Error check to show the organ boundary and internal intersections
%     figure
%     plot(segmentX,segmentY)
%     hold on
%     scatter(lattice(theta),lattice(theta+size(lattice,2)/2))
%     hold off


%Find the faces which contain the organ boundary
tempID = faceIDFind([segmentX,segmentY],latticeV,latticeF);
tempFace = unique(tempID);

%Initialise vector storing boundary vertex coordinates
f1 = [];
for i = 1:size(tempFace,1) %For each face that contains the organ boundary...
    theta = [theta,latticeF(tempFace(i),:)]; %Add to theta the vertex coordinates of that face
    for j = 1:4 %For the four coordinates added...
        [~,localIndex] = neighbours(latticeF(tempFace(i),j),latticeV,cols); %Find the neighbouring vertices
        %Add any neighour vertices that are not in the calculation domain into
        %the boundary domain.
        f1 = [f1, localIndex(~ismember(localIndex,theta))]; 
    end
end

theta = unique(theta); %Delete duplicate entries
f1 = f1(~ismember(f1,theta)); %Second check to delete members of the calculation domain
f1 = unique(f1); %Delete  duplicates
f2 = [f1(1),f1(2)]; %Create the boundary of the boundary domain arbitratily.

clear tempID tempFace localIndex