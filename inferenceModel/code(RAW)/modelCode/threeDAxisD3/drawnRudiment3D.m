[object.vertices,object.faces] = stlread('sellipsoid2.STL');
tx = object.vertices(:,1);
ty = object.vertices(:,2);
tz = object.vertices(:,3);
% for i = 1:size(faces,1)
%     %     faceDef = [1 4 2;2 4 3;...
%     %         5 6 8; 6 7 8;...
%     %         4 7 3; 8 7 4;...
%     %         1 2 6; 5 1 6;...
%     %         1 5 4; 4 5 8;...
%     %         2 3 6; 3 7 6];
%     %     Make shapes for inpolyhedron from cubes.
%     % Look for cubes that contain mesh vertices.
%     % If yes, create the reconstruction coefficients.
%     % Store the cube index? And the coefficients.
%     
%     insideV = find((tx>min(lattice(faces(i,:)))).*(tx<max(lattice(faces(i,:)))).*(ty>min(lattice(faces(i,:)+end/3))).*(ty<max(lattice(faces(i,:)+end/3))).*(tz>min(lattice(faces(i,:)+2*end/3))).*(tz<max(lattice(faces(i,:)+2*end/3))));
%     %now we have the vertices contained within a certain cube.
%     %     Considering that we want to make reconstruction coefficients out of
%     %     these, we should probalby store each vertex with the index of the
%     %     cube that contains it. I think we can just stick it as another field
%     %     in object. It is going to be indexed by the vertices, and contain the
%     %     row in faces.
%     for k = insideV'
%         object.vertexCube(k,:) = faces(i,:);
%     end
%     
%     
%     
%     %     Do for all
%     %     gives me cubes that contain vertices, as well as which ones.
%     %     then need to use these to calculate coefficients.
%     %     can steal the code from a solve.
% end
% 
% % Calculatin the interpolation coefficients requires the coordinate values
% % of the faces, and then the vertex
% object.vertexCoef = zeros(size(object.vertexCube));
% for i = 1:size(object.vertexCoef,1)
%     object.vertexCoef(i,:) = interpolationCoef3D([lattice(object.vertexCube(i,:)),lattice(object.vertexCube(i,:)+N),lattice(object.vertexCube(i,:)+2*N)],object.vertices(i,:));
% end