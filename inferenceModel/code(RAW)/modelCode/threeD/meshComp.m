figure
meshEst.vertices = zeros(size(object.vertices));
for i = 1:size(object.vertices,1)%Create limb shape estimate
meshEst.vertices(i,:) = object.vertexCoef(i,:)*[latticeNew(object.vertexCube(i,:))',latticeNew(object.vertexCube(i,:)+N)',latticeNew(object.vertexCube(i,:)+2*N)'];
end
meshEst.faces = object.faces;
patch('Faces',meshEst.faces,'Vertices',meshEst.vertices,'FaceColor','red')
hold on
patch('Faces',objectN.faces,'Vertices',objectN.vertices,'FaceColor','green')
hold off