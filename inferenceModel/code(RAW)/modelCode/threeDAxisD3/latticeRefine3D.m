%In this script, the lattice is refined to only include relevant
%intersections. The space the lattice defines is a cuboid, however tissue
%geometries are not (may be rounded, have concavities etc.) We define a
%calculation domain theta, and boundary domains f1 and f2 as described in
%the thesis.

%Find the intersections contained within the geometry.
in = inpolyhedron(object,[lattice(1:end/3)',lattice(end/3 + 1:2*end/3)',lattice(1+2*end/3 : end)']);
theta = find(in)';

%The calculation domain is incomplete at this stage, as it should include
%another layer of intersections outside of the geometry

temp = [];
for i = 1:size(theta,2)
    [~,localIndex] = neighbours83D(theta(1,i),lattice,cols,rows); %find the nieghbours of the current members of theta
    temp = [temp,localIndex(find(~ismember(localIndex,theta)))]; %Store the neighbours not currently contained in theta
end

%The f4 domain, used in the convolution correction contains only this outer
%layer. it is further refined to a target region of interest, in the commented case case,
%intersections with a z value within a certain region. This helps to reduce
%runtime, which is greatly needed.

f4 = unique(temp);
%f4(find(lattice(f4+2*N)<500)) = [];

%the f1, or boundary domain, contains the neighbours of this outer layer
f1 = [];
for i = 1:size(temp,2)
    [~,localIndex] = neighbours3D(temp(1,i),lattice,cols,rows);
    f1 = [f1,localIndex(find(~ismember(localIndex,theta)))]; %Add neighbours that are not in theta
end

theta = [theta,temp]; %Add the outer layer to theta
theta = unique(theta); %Remove duplicates
f1 = f1(~ismember(f1,theta)); %Double check to remove any theta from the boundary
f1 = unique(f1); %Remove duplicates

%Due to concavities and general curvature, some dense boundary regions
%appear. In this case, these are added to the calculation domain
temp = [];
for i = 1:size(f1,2)
    [~,localIndex] = neighbours83D(f1(1,i),lattice,cols,rows);
    if sum(ismember(localIndex,f1)) == 9 %if a member of f1 is a dense boundary region...
        theta = [theta,f1(1,i)]; %...add it to theta and...
        temp = [temp,f1(1,i)]; %add it to a separate list for later deletion
    end
end

%Need to add any potential new boundary intersections.
for i = 1:size(temp,2)
    [~,localIndex] = neighbours3D(temp(1,i),lattice,cols,rows);
    f1 = [f1,localIndex.*~ismember(localIndex,theta).*~ismember(localIndex,f1)];
end

%Delete any intersections in dense boundary regions
f1(find(ismember(f1,temp))) = [];
f1 = f1(find(f1));

%Bottom face of the lattice is set as the hyper-boundary initially
f2 = f1(lattice(f1)==0);

%Need to find the centroid of the rudiment vaguely,
centroid = [0,mean(object.vertices(:,2)),mean(object.vertices(:,3))];
%find lattice points within one lattice resolution of the center
f2 = f2(find(ismembertol(lattice(f2+N),centroid(2),object.resolution(2),'DataScale',1).*ismembertol(lattice(f2+2*N),centroid(3),object.resolution(3),'DataScale',1)));
%f3 is unused in the current likelihood function
f3 = [f2(1), f2(2)];
clear tempID tempFace localIndex