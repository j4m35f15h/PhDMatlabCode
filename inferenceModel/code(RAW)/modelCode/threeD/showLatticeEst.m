tx = object.vertices(:,1);
ty = object.vertices(:,2);
tz = object.vertices(:,3);
for i = 1:size(faces,1)
    
    
    insideV = find((tx>min(lattice(faces(i,:)))).*(tx<max(lattice(faces(i,:)))).*(ty>min(lattice(faces(i,:)+end/3))).*(ty<max(lattice(faces(i,:)+end/3))).*(tz>min(lattice(faces(i,:)+2*end/3))).*(tz<max(lattice(faces(i,:)+2*end/3))));
    %Which vertices are in the cube
    for k = insideV'
        object.vertexCube(k,:) = faces(i,:);%Which cube contains each vertex
    end
end

% Calculate the interpolation coefficients, indexed by vertex 
object.vertexCoef = zeros(size(object.vertexCube));
for i = 1:size(object.vertexCoef,1)
    object.vertexCoef(i,:) = interpolationCoef3D([lattice(object.vertexCube(i,:)),lattice(object.vertexCube(i,:)+N),lattice(object.vertexCube(i,:)+2*N)],object.vertices(i,:));
end
%use coordinate of lattice estimate with coefficients
meshEst = zeros(size(object.vertices));
for i = 1:size(object.vertices,1)
    meshEst(i,:) = object.vertexCoef(i,:)*[latticeNew(object.vertexCube(i,:))',latticeNew(object.vertexCube(i,:)+N)',latticeNew(object.vertexCube(i,:)+2*N)'];
end

figure
hold on
scatter3(latticeNew(1,theta),latticeNew(1,theta+N),latticeNew(1,theta+2*N))
scatter3(latticeNew(1,f1),latticeNew(1,f1+N),latticeNew(1,f1+2*N))
scatter3(latticeNew(1,f2),latticeNew(1,f2+N),latticeNew(1,f2+2*N))
patch('Faces',object.faces,'Vertices',meshEst,'FaceColor','blue')
hold off