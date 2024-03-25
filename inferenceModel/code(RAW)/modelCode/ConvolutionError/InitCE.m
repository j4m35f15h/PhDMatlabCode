%This script alters the object which describes the starting geometry to 
%allow for the convolution correction. It finds interpolation coefficients
%for the vertices of the object, which will be deformed to create an
%estimated organ geometry

tx = object.vertices(:,1);
ty = object.vertices(:,2);
tz = object.vertices(:,3);
for i = 1:size(faces,1) %For each cube
    
    %Find the vertices of the mesh in the cube
    insideV = find((tx>min(lattice(faces(i,:)))).*(tx<max(lattice(faces(i,:)))).*(ty>min(lattice(faces(i,:)+end/3))).*(ty<max(lattice(faces(i,:)+end/3))).*(tz>min(lattice(faces(i,:)+2*end/3))).*(tz<max(lattice(faces(i,:)+2*end/3))));
    
    %Store the id of the cube associated with each vertex
    for k = insideV'
        object.vertexCube(k,:) = faces(i,:);
    end
    
end

% Calculatin the interpolation coefficients requires the coordinate values
% of the faces, and then the vertex

%Calculate the interpolation coefficients for each vertex of the mesh
object.vertexCoef = zeros(size(object.vertexCube));
for i = 1:size(object.vertexCoef,1)
    object.vertexCoef(i,:) = interpolationCoef3D([lattice(object.vertexCube(i,:)),lattice(object.vertexCube(i,:)+N),lattice(object.vertexCube(i,:)+2*N)],object.vertices(i,:));
end
