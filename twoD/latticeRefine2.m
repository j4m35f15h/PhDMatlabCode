%Need to include lattice points in the polygon & lattice points that are
%part of the faces in faceID done on the boundary points.
%Lattice points within the polygon are in the calculation domain. %Lattice
%points within faceId run on the rudiment outline are in the calculation
%domain. The Last groups neighbours are the boundary points.
in = inpolygon(lattice(1:end/2),lattice(end/2 + 1:end),segmentX,segmentY);
theta = find(in);

% figure
% plot(segmentX,segmentY)
% hold on
% scatter(lattice(theta),lattice(theta+size(lattice,2)/2))
% hold off

tempID = faceIDFind([segmentX,segmentY],lattice,faces);
tempFace = unique(tempID);
% tempFace(1) = [];
f1 = [];
for i = 1:size(tempFace,1)
    theta = [theta,faces(tempFace(i),:)];
    for j = 1:4
        [~,localIndex] = neighbours(faces(tempFace(i),j),lattice,cols);
        f1 = [f1, localIndex(~ismember(localIndex,theta))];
    end
end

theta = unique(theta);
f1 = f1(~ismember(f1,theta));
f1 = unique(f1);

theta = [theta,f1];
f1 = [];
f2 = [];
for i = 1:size(theta,2)
    [~,localIndex] = neighbours(theta(1,i),lattice,cols);
    f1 = [f1,localIndex(~ismember(localIndex,theta))];
end
for i = 1:size(lattice,2)/2
    if lattice(i) > 0 && lattice(i) < 0.1 && lattice(i + N) <0.55 && lattice(i+N) > 0.4
        f2 = [f2,i];
    end
end
f1 = unique(f1);
f1(find(f1 == f2(1))) = [];
f1(find(f1 == f2(2))) = [];
theta = unique(theta);

clear tempID tempFace localIndex