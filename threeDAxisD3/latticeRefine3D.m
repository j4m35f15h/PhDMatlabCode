%Need to include lattice points in the polygon & lattice points that are
%part of the faces in faceID done on the boundary points.
%Lattice points within the polygon are in the calculation domain. %Lattice
%points within faceId run on the rudiment outline are in the calculation
%domain. The Last groups neighbours are the boundary points.
in = inpolyhedron(object,[lattice(1:end/3)',lattice(end/3 + 1:2*end/3)',lattice(1+2*end/3 : end)']);
theta = find(in)';

temp = [];
for i = 1:size(theta,2)
    [~,localIndex] = neighbours83D(theta(1,i),lattice,cols,rows);
    temp = [temp,localIndex(find(~ismember(localIndex,theta)))];
end
f4 = unique(temp);
f4(find(lattice(f4+2*N)<500)) = [];
f1 = [];
for i = 1:size(temp,2)
    [~,localIndex] = neighbours3D(temp(1,i),lattice,cols,rows);
    f1 = [f1,localIndex(find(~ismember(localIndex,theta)))];
end
theta = [theta,temp];
theta = unique(theta);
f1 = f1(~ismember(f1,theta));
f1 = unique(f1);
temp = [];
for i = 1:size(f1,2)
    [~,localIndex] = neighbours83D(f1(1,i),lattice,cols,rows);
    if sum(ismember(localIndex,f1)) == 9
        theta = [theta,f1(1,i)];
        temp = [temp,f1(1,i)];
    end
end

for i = 1:size(temp,2)
    [~,localIndex] = neighbours3D(temp(1,i),lattice,cols,rows);
    f1 = [f1,localIndex.*~ismember(localIndex,theta).*~ismember(localIndex,f1)];
end



f1(find(ismember(f1,temp))) = [];
f1 = f1(find(f1));


f2 = f1(lattice(f1)==0);
%Need to find the centroid of the rudiment vaguely,
centroid = [0,mean(object.vertices(:,2)),mean(object.vertices(:,3))];
%find lattice points within one lattice division
f2 = f2(find(ismembertol(lattice(f2+N),centroid(2),object.resolution(2),'DataScale',1).*ismembertol(lattice(f2+2*N),centroid(3),object.resolution(3),'DataScale',1)));
f3 = [f2(1), f2(2)];
clear tempID tempFace localIndex